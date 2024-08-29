const std = @import("std");
const builtin = @import("builtin");

const common = @import("../common/data.zig");
const options = @import("../common/options.zig");
const protocol = @import("../common/protocol.zig");
const rng = @import("../common/rng.zig");

const data = @import("data.zig");

const assert = std.debug.assert;

const Choice = common.Choice;
const Player = common.Player;

const showdown = options.showdown;
const chance = options.chance;

const PSRNG = rng.PSRNG;

const DVs = data.DVs;
const Move = data.Move;
const MoveSlot = data.MoveSlot;
const Species = data.Species;
const Stats = data.Stats;
const Status = data.Status;

const endian = builtin.cpu.arch.endian();

/// Configuration options controlling the domain of valid Pokémon that can be generated by the
/// random generator helpers.
pub const Options = struct {
    /// Whether to generate Pokémon adhering to "Cleric Clause".
    cleric: bool = showdown,
    /// Whether to generate Pokémon with moves that contain bugs on Pokémon Showdown that are
    /// unimplementable in the engine.
    block: bool = showdown,
    // FIXME: remove once durations work with -Dchance
    durations: bool = false,
};

/// Helpers to simplify initialization of a Generation I battle.
pub const Battle = struct {
    /// Initializes a Generation I battle with the teams specified by `p1` and `p2`
    /// and an RNG whose seed is derived from `seed`.
    pub fn init(
        seed: u64,
        p1: []const Pokemon,
        p2: []const Pokemon,
    ) data.Battle(data.PRNG) {
        var rand = PSRNG.init(seed);
        return .{
            .rng = prng(&rand),
            .sides = .{ Side.init(p1), Side.init(p2) },
        };
    }

    /// Initializes a Generation I battle with the teams specified by `p1` and `p2`
    /// and a FixedRNG that returns the provided `rolls`.
    pub fn fixed(
        comptime rolls: anytype,
        p1: []const Pokemon,
        p2: []const Pokemon,
    ) data.Battle(rng.FixedRNG(1, rolls.len)) {
        return .{
            .rng = .{ .rolls = rolls },
            .sides = .{ Side.init(p1), Side.init(p2) },
        };
    }

    /// Returns a Generation I battle that is randomly generated based on the `rand` and `opts`.
    pub fn random(rand: *PSRNG, opts: Options) data.Battle(data.PRNG) {
        return .{
            .rng = prng(rand),
            .turn = 0,
            .last_damage = 0,
            .sides = .{ Side.random(rand, opts), Side.random(rand, opts) },
        };
    }
};

fn prng(rand: *PSRNG) data.PRNG {
    return .{
        .src = .{
            .seed = if (showdown)
                rand.newSeed()
            else seed: {
                // GLITCH: The initial RNG seed in Gen I link battles is heavily constrained
                // https://www.smogon.com/forums/threads/rng-in-rby-link-battles.3746779
                var seed = [_]u8{ 0, 0, 0, 0, 0, 0, 0, 0, 0 };

                // Bytes in seed can only range from 0-252, not 0-255
                const max: u8 = 253;
                // Instructions take multiples of 4 cycles to execute
                var timer: u16 = 4 * rand.range(u16, 0, 16384);
                var add: u8 = rand.range(u8, 0, 256);
                var carry: u8 = 0;

                var i: u8 = 0;
                while (i < seed.len) {
                    const div: u8 = @intCast(timer >> 8);
                    add +%= div +% carry;
                    if (add < max) {
                        seed[i] = add;
                        i += 1;
                        timer +%= 472;
                        carry = 1;
                    } else {
                        timer +%= 452;
                        carry = 0;
                    }
                }
                break :seed seed;
            },
        },
    };
}

/// Helpers to simplify initialization of a Generation I side.
pub const Side = struct {
    /// Initializes a Generation I side with the team specified by `ps`.
    pub fn init(ps: []const Pokemon) data.Side {
        assert(ps.len > 0 and ps.len <= 6);
        var side = data.Side{};

        for (0..ps.len) |i| {
            side.pokemon[i] = Pokemon.init(ps[i]);
            side.order[i] = @as(u4, @intCast(i)) + 1;
        }
        return side;
    }

    /// Returns a Generation I side that is randomly generated based on the `rand` and `opts`.
    pub fn random(rand: *PSRNG, opts: Options) data.Side {
        const n = if (rand.chance(u8, 1, 100)) rand.range(u4, 1, 5 + 1) else 6;
        var side = data.Side{};

        for (0..n) |i| {
            side.pokemon[i] = Pokemon.random(rand, opts);
            side.order[i] = @as(u4, @intCast(i)) + 1;
        }

        return side;
    }
};

/// The maximum stat experience possible in Generation I.
pub const EXP = 0xFFFF;

/// Helpers to simplify initialization of a Generation I Pokémon.
pub const Pokemon = struct {
    /// The Pokémon's species.
    species: Species,
    /// The Pokémon's moves (assumed to all have the max possible PP).
    moves: []const Move,
    /// The Pokémon's current HP (defaults to 100% if not specified).
    hp: ?u16 = null,
    /// The Pokémon's current status.
    status: u8 = 0,
    /// The Pokémon's level.
    level: u8 = 100,
    /// The Pokémon's DVs.
    dvs: DVs = .{},
    /// The Pokémon's stat experience.
    stats: Stats(u16) = .{ .hp = EXP, .atk = EXP, .def = EXP, .spe = EXP, .spc = EXP },

    /// Initializes a Generation I Pokémon based on the information in `p`.
    pub fn init(p: Pokemon) data.Pokemon {
        var pokemon = data.Pokemon{};
        pokemon.species = p.species;
        const species = Species.get(p.species);
        inline for (@typeInfo(@TypeOf(pokemon.stats)).Struct.fields) |field| {
            const hp = comptime std.mem.eql(u8, field.name, "hp");
            const spc =
                comptime std.mem.eql(u8, field.name, "spa") or std.mem.eql(u8, field.name, "spd");
            @field(pokemon.stats, field.name) = Stats(u16).calc(
                field.name,
                @field(species.stats, field.name),
                if (hp) p.dvs.hp() else if (spc) p.dvs.spc else @field(p.dvs, field.name),
                @field(p.stats, field.name),
                p.level,
            );
        }
        assert(p.moves.len > 0 and p.moves.len <= 4);
        for (p.moves, 0..) |m, j| {
            pokemon.moves[j].id = m;
            // NB: PP can be at most 61 legally (though can overflow to 63)
            pokemon.moves[j].pp = @intCast(@min(Move.pp(m) / 5 * 8, 61));
        }
        if (p.hp) |hp| {
            pokemon.hp = hp;
        } else {
            pokemon.hp = pokemon.stats.hp;
        }
        pokemon.status = p.status;
        pokemon.types = species.types;
        pokemon.level = p.level;
        return pokemon;
    }

    /// Returns a Generation I Pokémon that is randomly generated based on the `rand` and `opts`.
    pub fn random(rand: *PSRNG, opt: Options) data.Pokemon {
        const s: Species = @enumFromInt(rand.range(u8, 1, Species.size + 1));
        const species = Species.get(s);
        const lvl = if (rand.chance(u8, 1, 20)) rand.range(u8, 1, 99 + 1) else 100;
        var stats: Stats(u16) = .{};
        const dvs = DVs.random(rand);
        inline for (@typeInfo(@TypeOf(stats)).Struct.fields) |field| {
            @field(stats, field.name) = Stats(u16).calc(
                field.name,
                @field(species.stats, field.name),
                if (comptime std.mem.eql(u8, field.name, "hp"))
                    dvs.hp()
                else
                    @field(dvs, field.name),
                if (rand.chance(u8, 1, 20)) rand.range(u16, 0, EXP + 1) else EXP,
                lvl,
            );
        }

        var ms = [_]MoveSlot{.{}} ** 4;
        const n = if (rand.chance(u8, 1, 100)) rand.range(u4, 1, 3 + 1) else 4;
        for (0..n) |i| {
            var m: Move = .None;
            sample: while (true) {
                m = @enumFromInt(rand.range(u8, 1, Move.size - 1 + 1));
                if (opt.durations and durations(m)) continue :sample;
                if (opt.block and blocked(m)) continue :sample;
                for (0..i) |j| if (ms[j].id == m) continue :sample;
                break;
            }
            const pp_ups: u8 =
                if (!opt.cleric and rand.chance(u8, 1, 10)) rand.range(u2, 0, 2 + 1) else 3;
            // NB: PP can be at most 61 legally (though can overflow to 63)
            const max_pp: u8 = @intCast(Move.pp(m) + pp_ups * @min(Move.pp(m) / 5, 7));
            ms[i] = .{
                .id = m,
                .pp = if (opt.cleric) max_pp else rand.range(u8, 0, max_pp + 1),
            };
        }

        return .{
            .species = s,
            .types = species.types,
            .level = lvl,
            .stats = stats,
            .hp = if (opt.cleric) stats.hp else rand.range(u16, 0, stats.hp + 1),
            .status = if (!opt.cleric and rand.chance(u8, 1, 6 + 1))
                // NB: This will only assign sleep as 2 or 4 when rolled
                0 | (@as(u8, 1) << rand.range(u3, 1, 6 + 1))
            else
                0,
            .moves = ms,
        };
    }
};

fn blocked(m: Move) bool {
    // Binding moves are borked but only via Mirror Move / Metronome which are already blocked
    return switch (m) {
        .Mimic, .Metronome, .MirrorMove, .Transform => true,
        else => false,
    };
}

fn durations(m: Move) bool {
    // Any moves that have effects that result in duration tracking with -Dchance
    return switch (Move.get(m).effect) {
        .Confusion,
        .Bide,
        .Sleep,
        .Rage,
        .Binding,
        .Thrashing,
        .ConfusionChance,
        .Disable,
        .Metronome,
        => true,
        else => false,
    };
}

/// Convenience helper to create a move-type choice for the provided move slot.
pub fn move(slot: u4) Choice {
    return .{ .type = .Move, .data = slot };
}

/// Convenience helper to create a switch-type choice for the provided team slot.
pub fn swtch(slot: u4) Choice {
    return .{ .type = .Switch, .data = slot };
}

/// Empirically determined maximum number of bytes possibly required to store the diff between two
/// Generation I battles.
pub const MAX_DIFFS: usize = 120;

/// The optimal size in bytes required to hold the diff between two Generation I battles.
/// At least as large as MAX_DIFFS.
pub const DIFFS_SIZE = if (builtin.mode == .ReleaseSmall)
    MAX_DIFFS
else
    std.math.ceilPowerOfTwo(usize, MAX_DIFFS) catch unreachable;

/// TODO
pub fn diff(
    a: *const data.Battle(data.PRNG),
    b: *const data.Battle(data.PRNG),
    w: protocol.ByteStream.Writer,
) !usize {
    const pos = w.stream.pos;
    const size = @sizeOf(data.Battle(data.PRNG)) - @sizeOf(data.PRNG);
    assert(size % 2 == 0);
    assert(size / 2 < 255);

    var i: usize = 0;
    while (i < size) : (i += 2) {
        const val = bytesAsValue(u16, std.mem.asBytes(a)[i .. i + 2]).*;
        if (val != bytesAsValue(u16, std.mem.asBytes(b)[i .. i + 2]).*) {
            try w.writeByte(@intCast(i / 2));
            try w.writeInt(u16, val, endian);
        }
    }

    return w.stream.pos - pos;
}

/// TODO
pub fn patch(battle: *data.Battle(data.PRNG), buf: []u8) void {
    var i: usize = 0;
    while (i < buf.len) : (i += 3) {
        const off = @as(u16, @intCast(buf[i])) * 2;
        const val = std.mem.readInt(u16, @as(*const [2]u8, @ptrCast(buf[i + 1 .. i + 3])), endian);
        const bytes: *[2]u8 = @ptrCast(std.mem.asBytes(battle)[off .. off + 2]);
        std.mem.writeInt(u16, bytes, val, endian);
    }
}

// NOTE: std.mem.bytesAsValue backported from ziglang/zig#18061
fn bytesAsValue(comptime T: type, bytes: anytype) BytesAsValueReturnType(T, @TypeOf(bytes)) {
    return @as(BytesAsValueReturnType(T, @TypeOf(bytes)), @ptrCast(bytes));
}

fn BytesAsValueReturnType(comptime T: type, comptime B: type) type {
    return CopyPtrAttrs(B, .One, T);
}

fn CopyPtrAttrs(
    comptime source: type,
    comptime size: std.builtin.Type.Pointer.Size,
    comptime child: type,
) type {
    const info = @typeInfo(source).Pointer;
    return @Type(.{
        .Pointer = .{
            .size = size,
            .is_const = info.is_const,
            .is_volatile = info.is_volatile,
            .is_allowzero = info.is_allowzero,
            .alignment = info.alignment,
            .address_space = info.address_space,
            .child = child,
            .sentinel = null,
        },
    });
}
