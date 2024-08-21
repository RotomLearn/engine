const std = @import("std");

const assert = std.debug.assert;
const print = std.debug.print;

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

const DEBUG = @import("../common/debug.zig").print;
const options = @import("../common/options.zig");
const rational = @import("../common/rational.zig");
const util = @import("../common/util.zig");

const Player = @import("../common/data.zig").Player;
const Optional = @import("../common/optional.zig").Optional;

const data = @import("data.zig");

const enabled = options.chance;
const showdown = options.showdown;

const Move = data.Move;
const MoveSlot = data.MoveSlot;

/// Actions taken by a hypothetical "chance player" that convey information about which RNG events
/// were observed during a Generation I battle `update`. This can additionally be provided as input
/// to the `update` call to override the normal behavior of the RNG in order to force specific
/// outcomes.
pub const Actions = extern struct {
    /// Information about the RNG activity for Player 1.
    p1: Action = .{},
    /// Information about the RNG activity for Player 2.
    p2: Action = .{},

    comptime {
        assert(@sizeOf(Actions) == 16);
    }

    /// Returns the `Action` for the given `player`.
    pub fn get(self: anytype, player: Player) util.PointerType(@TypeOf(self), Action) {
        assert(@typeInfo(@TypeOf(self)).Pointer.child == Actions);
        return if (player == .P1) &self.p1 else &self.p2;
    }

    /// Returns true if `a` is equal to `b`.
    pub fn eql(a: Actions, b: Actions) bool {
        return @as(u128, @bitCast(a)) == @as(u128, @bitCast(b));
    }

    /// Returns true if `a` has the same "shape" as `b`, where `Actions` are defined to have the
    /// same shape if they have the same fields set (though those fields need not necessarily be
    /// set to the same value).
    pub fn matches(a: Actions, b: Actions) bool {
        inline for (@typeInfo(Actions).Struct.fields) |player| {
            inline for (@typeInfo(Action).Struct.fields) |field| {
                const a_val = @field(@field(a, player.name), field.name);
                const b_val = @field(@field(b, player.name), field.name);

                switch (@typeInfo(@TypeOf(a_val))) {
                    .Enum => if ((@intFromEnum(a_val) > 0) != (@intFromEnum(b_val) > 0))
                        return false,
                    .Int => if ((a_val > 0) != (b_val > 0)) return false,
                    else => unreachable,
                }
            }
        }
        return true;
    }

    pub fn fmt(self: Actions, writer: anytype, shape: bool) !void {
        try writer.writeAll("<P1 = ");
        try self.p1.fmt(writer, shape);
        try writer.writeAll(", P2 = ");
        try self.p2.fmt(writer, shape);
        try writer.writeAll(">");
    }

    pub fn format(a: Actions, comptime f: []const u8, o: std.fmt.FormatOptions, w: anytype) !void {
        _ = .{ f, o };
        try fmt(a, w, false);
    }
};

test Actions {
    const a: Actions = .{ .p1 = .{ .hit = .true, .critical_hit = .false, .damage = 245 } };
    const b: Actions = .{ .p1 = .{ .hit = .false, .critical_hit = .true, .damage = 246 } };
    const c: Actions = .{ .p1 = .{ .hit = .true } };

    try expect(a.eql(a));
    try expect(!a.eql(b));
    try expect(!b.eql(a));
    try expect(!a.eql(c));
    try expect(!c.eql(a));

    try expect(a.matches(a));
    try expect(a.matches(b));
    try expect(b.matches(a));
    try expect(!a.matches(c));
    try expect(!c.matches(a));
}

/// TODO
pub const Duration = enum { extend, end };
/// TODO
pub const Thrashing = enum { confirmed, unconfirmed };

/// Information about the RNG that was observed during a Generation I battle `update` for a
/// single player.
pub const Action = packed struct(u64) {
    /// If not 0, the roll to be returned Rolls.damage.
    damage: u8 = 0,

    /// If not None, the value to return for Rolls.hit.
    hit: Optional(bool) = .None,
    /// If not None, the value to be returned by Rolls.criticalHit.
    critical_hit: Optional(bool) = .None,
    /// If not None, the value to be returned for
    /// Rolls.{confusionChance,secondaryChance,poisonChance}.
    secondary_chance: Optional(bool) = .None,
    /// If not None, the Player to be returned by Rolls.speedTie.
    speed_tie: Optional(Player) = .None,

    /// If not None, the value to return for Rolls.confused.
    confused: Optional(bool) = .None,
    /// If not None, the value to return for Rolls.paralyzed.
    paralyzed: Optional(bool) = .None,
    /// If not 0, the value to be returned by Rolls.distribution in the case of binding moves
    /// or Rolls.{sleepDuration,disableDuration,confusionDuration,attackingDuration} otherwise.
    duration: u4 = 0,

    // TODO
    sleep: Optional(Duration) = .None,
    confusion: Optional(Duration) = .None,
    disable: Optional(Duration) = .None,
    bide: Optional(Duration) = .None,
    binding: Optional(Duration) = .None,
    thrashing: Optional(Thrashing) = .None,

    _: u4 = 0, // TODO

    /// If not 0, the move slot (1-4) to return in Rolls.moveSlot. If present as an override,
    /// invalid values (eg. due to empty move slots or 0 PP) will be ignored.
    move_slot: u4 = 0,
    /// If not 0, the value (2-5) to return for Rolls.distribution for multi hit.
    multi_hit: u4 = 0,

    /// If not 0, psywave - 1 should be returned as the damage roll for Rolls.psywave.
    psywave: u8 = 0,

    /// If not None, the Move to return for Rolls.metronome.
    metronome: Move = .None,

    pub const Field = std.meta.FieldEnum(Action);

    pub fn format(a: Action, comptime f: []const u8, o: std.fmt.FormatOptions, w: anytype) !void {
        _ = .{ f, o };
        try fmt(a, w, false);
    }

    pub fn fmt(self: Action, writer: anytype, shape: bool) !void {
        try writer.writeByte('(');
        var printed = false;
        inline for (@typeInfo(Action).Struct.fields) |field| {
            const val = @field(self, field.name);
            switch (@typeInfo(@TypeOf(val))) {
                .Enum => if (val != .None) {
                    if (printed) try writer.writeAll(", ");
                    if (shape) {
                        try writer.print("{s}:?", .{field.name});
                    } else if (@TypeOf(val) == Optional(bool)) {
                        try writer.print("{s}{s}", .{
                            if (val == .false) "!" else "",
                            field.name,
                        });
                    } else if (@TypeOf(val) == Optional(Duration)) {
                        try writer.print("{s}{s}", .{
                            if (val == .extend) "+" else "-",
                            field.name,
                        });
                    } else if (@TypeOf(val) == Optional(Thrashing)) {
                        try writer.print("{s}{s}", .{
                            if (val == .unconfirmed) "~" else "",
                            field.name,
                        });
                    } else {
                        try writer.print("{s}:{s}", .{ field.name, @tagName(val) });
                    }
                    printed = true;
                },
                .Int => if (val != 0) {
                    if (printed) try writer.writeAll(", ");
                    if (shape) {
                        try writer.print("{s}:?", .{field.name});
                    } else {
                        try writer.print("{s}:{d}", .{ field.name, val });
                    }
                    printed = true;
                },
                else => unreachable,
            }
        }
        try writer.writeByte(')');
    }
};

pub const Commit = enum { hit, miss };

const uN = if (options.miss) u8 else u9;

/// Tracks chance actions and their associated probability during a Generation I battle update when
/// `options.chance` is enabled.
pub fn Chance(comptime Rational: type) type {
    return struct {
        const Self = @This();

        /// The probability of the actions taken by a hypothetical "chance player" occurring.
        probability: Rational,
        /// The actions taken by a hypothetical "chance player" that convey information about which
        /// RNG events were observed during a battle `update`.
        actions: Actions = .{},

        // In many cases on both the cartridge and on Pokémon Showdown rolls are made even though
        // later checks render their result irrelevant (missing when the target is actually immune,
        // rolling for damage when the move is later revealed to have missed, etc). We can't reorder
        // the logic to ensure we only ever make rolls when required due to our desire to maintain
        // RNG frame accuracy, so instead we save these "pending" updates to the probability and
        // only commit them once we know they are relevant (a naive solution would be to instead
        // update the probability eagerly and later "undo" the update by multiplying by the inverse
        // but this would be more costly and also error prone in the presence of
        // overflow/normalization).
        //
        // This design deliberately make use of the fact that recursive moves on the cartridge may
        // overwrite critical hit information multiple times as only the last update actually
        // matters for the purposes of the logical results.
        //
        // Finally, because each player's actions are processed sequentially we only need a single
        // shared structure to track this information (though it needs to be cleared appropriately)
        pending: if (showdown) struct {} else struct {
            crit: bool = false,
            crit_probablity: u8 = 0,
            damage_roll: u8 = 0,
            hit: bool = false,
            hit_probablity: uN = 0,
        } = .{},

        /// Possible error returned by operations tracking chance probability.
        pub const Error = Rational.Error;

        /// Convenience helper to clear fields which typically should be cleared between updates.
        pub fn reset(self: *Self) void {
            if (!enabled) return;

            self.probability.reset();
            self.actions = .{};
            self.pending = .{};
        }

        pub fn commit(self: *Self, player: Player, kind: Commit) Error!void {
            if (!enabled) return;

            assert(!showdown);

            var action = self.actions.get(player);

            // Always commit the hit result if we make it here (commit won't be called at all if the
            // target is immune/behind a sub/etc)
            if (self.pending.hit_probablity != 0) {
                try self.probability.update(self.pending.hit_probablity, 256);
                action.hit = if (self.pending.hit) .true else .false;
            }

            // If the move actually lands we can commit any past critical hit / damage rolls. Note
            // we can't rely on the presence or absence of a damage roll to determine whether a
            // "critical hit" was spurious or not as moves that do 1 or less damage don't rol for
            // damage but can still crit (instead, whether or not a roll is deemed to be a no-op is
            // passed to the critical hit helper)
            if (kind != .hit) return assert(!self.pending.crit or self.pending.crit_probablity > 0);

            if (self.pending.crit_probablity != 0) {
                try self.probability.update(self.pending.crit_probablity, 256);
                action.critical_hit = if (self.pending.crit) .true else .false;
            }

            if (self.pending.damage_roll > 0) {
                try self.probability.update(1, 39);
                action.damage = self.pending.damage_roll;
            }
        }

        pub fn clearPending(self: *Self) void {
            if (!enabled) return;

            self.pending = .{};
        }

        pub fn speedTie(self: *Self, p1: bool) Error!void {
            if (!enabled) return;

            try self.probability.update(1, 2);
            self.actions.p1.speed_tie = if (p1) .P1 else .P2;
            self.actions.p2.speed_tie = self.actions.p1.speed_tie;
        }

        pub fn hit(self: *Self, player: Player, ok: bool, accuracy: uN) Error!void {
            if (!enabled) return;

            const p = if (ok) accuracy else @as(u8, @intCast(256 - @as(u9, accuracy)));
            if (showdown) {
                try self.probability.update(p, 256);
                self.actions.get(player).hit = if (ok) .true else .false;
            } else {
                self.pending.hit = ok;
                self.pending.hit_probablity = p;
            }
        }

        pub fn criticalHit(self: *Self, player: Player, crit: bool, rate: u8) Error!void {
            if (!enabled) return;

            const n = if (crit) rate else @as(u8, @intCast(256 - @as(u9, rate)));
            if (showdown) {
                try self.probability.update(n, 256);
                self.actions.get(player).critical_hit = if (crit) .true else .false;
            } else {
                self.pending.crit = crit;
                self.pending.crit_probablity = n;
            }
        }

        pub fn damage(self: *Self, player: Player, roll: u8) Error!void {
            if (!enabled) return;

            if (showdown) {
                try self.probability.update(1, 39);
                self.actions.get(player).damage = roll;
            } else {
                self.pending.damage_roll = roll;
            }
        }

        pub fn secondaryChance(self: *Self, player: Player, proc: bool, rate: u8) Error!void {
            if (!enabled) return;

            const n = if (proc) rate else @as(u8, @intCast(256 - @as(u9, rate)));
            try self.probability.update(n, 256);
            self.actions.get(player).secondary_chance = if (proc) .true else .false;
        }

        pub fn confused(self: *Self, player: Player, cfz: bool) Error!void {
            if (!enabled) return;

            try self.probability.update(1, 2);
            self.actions.get(player).confused = if (cfz) .true else .false;
        }

        pub fn paralyzed(self: *Self, player: Player, par: bool) Error!void {
            if (!enabled) return;

            try self.probability.update(@as(u8, if (par) 1 else 3), 4);
            self.actions.get(player).paralyzed = if (par) .true else .false;
        }

        pub fn moveSlot(
            self: *Self,
            player: Player,
            slot: u4,
            ms: []const MoveSlot,
            n: u4,
        ) Error!void {
            if (!enabled) return;

            const denominator = if (n != 0) n else denominator: {
                var i: usize = ms.len;
                while (i > 0) {
                    i -= 1;
                    if (ms[i].id != .None) break :denominator i + 1;
                }
                unreachable;
            };

            if (denominator != 1) try self.probability.update(1, denominator);
            self.actions.get(player).move_slot = @intCast(slot);
        }

        pub fn multiHit(self: *Self, player: Player, n: u3) Error!void {
            if (!enabled) return;

            try self.probability.update(@as(u8, if (n > 3) 1 else 3), 8);
            self.actions.get(player).multi_hit = n;
        }

        pub fn duration(self: *Self, player: Player, turns: u4) void {
            if (!enabled) return;

            self.actions.get(player).duration = if (options.key) 1 else turns;
        }

        pub fn psywave(self: *Self, player: Player, power: u8, max: u8) Error!void {
            if (!enabled) return;

            try self.probability.update(1, max);
            self.actions.get(player).psywave = power + 1;
        }

        pub fn metronome(self: *Self, player: Player, move: Move) Error!void {
            if (!enabled) return;

            try self.probability.update(1, Move.METRONOME.len);
            self.actions.get(player).metronome = move;
        }
    };
}

test "Chance.speedTie" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.speedTie(true);
    try expectProbability(&chance.probability, 1, 2);
    try expectValue(Optional(Player).P1, chance.actions.p1.speed_tie);
    try expectValue(chance.actions.p1.speed_tie, chance.actions.p2.speed_tie);

    chance.reset();

    try chance.speedTie(false);
    try expectProbability(&chance.probability, 1, 2);
    try expectValue(Optional(Player).P2, chance.actions.p1.speed_tie);
    try expectValue(chance.actions.p1.speed_tie, chance.actions.p2.speed_tie);
}

test "Chance.hit" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.hit(.P1, true, 229);
    if (!showdown) {
        try expectProbability(&chance.probability, 1, 1);
        try expectValue(Optional(bool).None, chance.actions.p1.hit);

        try chance.commit(.P1, .hit);
    }
    try expectValue(Optional(bool).true, chance.actions.p1.hit);
    try expectProbability(&chance.probability, 229, 256);

    chance.reset();

    try chance.hit(.P2, false, 255);
    if (!showdown) {
        try expectProbability(&chance.probability, 1, 1);
        try expectValue(Optional(bool).None, chance.actions.p2.hit);

        try chance.commit(.P2, .miss);
    }
    try expectValue(Optional(bool).false, chance.actions.p2.hit);
    try expectProbability(&chance.probability, 1, 256);
}

test "Chance.criticalHit" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.criticalHit(.P1, true, 17);
    if (showdown) {
        try expectValue(Optional(bool).true, chance.actions.p1.critical_hit);
        try expectProbability(&chance.probability, 17, 256);
    } else {
        try expectProbability(&chance.probability, 1, 1);
        try expectValue(Optional(bool).None, chance.actions.p1.critical_hit);

        try chance.hit(.P1, true, 128);

        try expectProbability(&chance.probability, 1, 1);
        try expectValue(Optional(bool).None, chance.actions.p1.critical_hit);

        try chance.damage(.P1, 217);

        try expectProbability(&chance.probability, 1, 1);
        try expectValue(Optional(bool).None, chance.actions.p1.critical_hit);

        try chance.commit(.P1, .hit);

        try expectProbability(&chance.probability, 17, 19968); // (1/2) * (17/256) * (1/39)
        try expectValue(Optional(bool).true, chance.actions.p1.critical_hit);
    }

    chance.reset();

    try chance.criticalHit(.P2, false, 5);
    if (showdown) {
        try expectProbability(&chance.probability, 251, 256);
        try expectValue(Optional(bool).false, chance.actions.p2.critical_hit);
    } else {
        try expectProbability(&chance.probability, 1, 1);
        try expectValue(Optional(bool).None, chance.actions.p1.critical_hit);

        try chance.hit(.P1, true, 128);

        try expectProbability(&chance.probability, 1, 1);
        try expectValue(Optional(bool).None, chance.actions.p1.critical_hit);

        try chance.damage(.P1, 217);
        try chance.commit(.P1, .hit);

        try expectProbability(&chance.probability, 251, 19968); // (1/2) * (251/256) * (1/39)
        try expectValue(Optional(bool).false, chance.actions.p1.critical_hit);
    }
}

test "Chance.damage" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.damage(.P1, 217);
    if (showdown) {
        try expectValue(217, chance.actions.p1.damage);
        try expectProbability(&chance.probability, 1, 39);
    } else {
        try expectProbability(&chance.probability, 1, 1);
        try expectValue(0, chance.actions.p1.damage);

        try chance.commit(.P1, .hit);

        try expectProbability(&chance.probability, 1, 39);
        try expectValue(217, chance.actions.p1.damage);
    }
}

test "Chance.secondaryChance" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.secondaryChance(.P1, true, 25);
    try expectProbability(&chance.probability, 25, 256);
    try expectValue(Optional(bool).true, chance.actions.p1.secondary_chance);

    chance.reset();

    try chance.secondaryChance(.P2, false, 77);
    try expectProbability(&chance.probability, 179, 256);
    try expectValue(Optional(bool).false, chance.actions.p2.secondary_chance);
}

test "Chance.confused" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.confused(.P1, false);
    try expectProbability(&chance.probability, 1, 2);
    try expectValue(Optional(bool).false, chance.actions.p1.confused);

    chance.reset();

    try chance.confused(.P2, true);
    try expectProbability(&chance.probability, 1, 2);
    try expectValue(Optional(bool).true, chance.actions.p2.confused);
}

test "Chance.paralyzed" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.paralyzed(.P1, false);
    try expectProbability(&chance.probability, 3, 4);
    try expectValue(Optional(bool).false, chance.actions.p1.paralyzed);

    chance.reset();

    try chance.paralyzed(.P2, true);
    try expectProbability(&chance.probability, 1, 4);
    try expectValue(Optional(bool).true, chance.actions.p2.paralyzed);
}

test "Chance.moveSlot" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };
    var ms = [_]MoveSlot{ .{ .id = Move.Surf }, .{ .id = Move.Psychic }, .{ .id = Move.Recover } };

    try chance.moveSlot(.P2, 2, &ms, 2);
    try expectProbability(&chance.probability, 1, 2);
    try expectValue(2, chance.actions.p2.move_slot);

    chance.reset();

    try chance.moveSlot(.P1, 1, &ms, 0);
    try expectProbability(&chance.probability, 1, 3);
    try expectValue(1, chance.actions.p1.move_slot);
}

test "Chance.multiHit" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.multiHit(.P1, 3);
    try expectProbability(&chance.probability, 3, 8);
    try expectValue(3, chance.actions.p1.multi_hit);

    chance.reset();

    try chance.multiHit(.P2, 5);
    try expectProbability(&chance.probability, 1, 8);
    try expectValue(5, chance.actions.p2.multi_hit);
}

test "Chance.duration" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    chance.duration(.P1, 2);
    try expectValue(2, chance.actions.p1.duration);

    chance.reset();

    chance.duration(.P2, 4);
    try expectValue(4, chance.actions.p2.duration);
}

test "Chance.psywave" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.psywave(.P2, 100, 150);
    try expectProbability(&chance.probability, 1, 150);
    try expectValue(101, chance.actions.p2.psywave);
}

test "Chance.metronome" {
    var chance: Chance(rational.Rational(u64)) = .{ .probability = .{} };

    try chance.metronome(.P1, Move.HornAttack);
    try expectProbability(&chance.probability, 1, 163);
    try expectValue(Move.HornAttack, chance.actions.p1.metronome);
}

pub fn expectProbability(r: anytype, p: u64, q: u64) !void {
    if (!enabled) return;

    r.reduce();
    if (r.p != p or r.q != q) {
        print("expected {d}/{d}, found {}\n", .{ p, q, r });
        return error.TestExpectedEqual;
    }
}

pub fn expectValue(a: anytype, b: anytype) !void {
    if (!enabled) return;

    try expectEqual(a, b);
}

/// Null object pattern implementation of Generation I `Chance` which does nothing, though chance
/// tracking should additionally be turned off entirely via `options.chance`.
pub const NULL: Null = .{};

const Null = struct {
    pub const Error = error{};

    pub fn commit(self: Null, player: Player, kind: Commit) Error!void {
        _ = .{ self, player, kind };
    }

    pub fn clearPending(self: Null) void {
        _ = .{self};
    }

    pub fn switched(self: Null, player: Player, in: u8, out: u8) void {
        _ = .{ self, player, in, out };
    }

    pub fn speedTie(self: Null, p1: bool) Error!void {
        _ = .{ self, p1 };
    }

    pub fn hit(self: Null, player: Player, ok: bool, accuracy: uN) Error!void {
        _ = .{ self, player, ok, accuracy };
    }

    pub fn criticalHit(self: Null, player: Player, crit: bool, rate: u8) Error!void {
        _ = .{ self, player, crit, rate };
    }

    pub fn damage(self: Null, player: Player, roll: u8) Error!void {
        _ = .{ self, player, roll };
    }

    pub fn confused(self: Null, player: Player, ok: bool) Error!void {
        _ = .{ self, player, ok };
    }

    pub fn paralyzed(self: Null, player: Player, ok: bool) Error!void {
        _ = .{ self, player, ok };
    }

    pub fn secondaryChance(self: Null, player: Player, proc: bool, rate: u8) Error!void {
        _ = .{ self, player, proc, rate };
    }

    pub fn moveSlot(self: Null, player: Player, slot: u4, ms: []const MoveSlot, n: u4) Error!void {
        _ = .{ self, player, slot, ms, n };
    }

    pub fn multiHit(self: Null, player: Player, n: u3) Error!void {
        _ = .{ self, player, n };
    }

    pub fn duration(self: Null, player: Player, turns: u4) void {
        _ = .{ self, player, turns };
    }

    pub fn psywave(self: Null, player: Player, power: u8, max: u8) Error!void {
        _ = .{ self, player, power, max };
    }

    pub fn metronome(self: Null, player: Player, move: Move) Error!void {
        _ = .{ self, player, move };
    }
};
