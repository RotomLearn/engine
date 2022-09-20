const std = @import("std");
const pkmn = @import("pkmn");

const Timer = std.time.Timer;
const Allocator = std.mem.Allocator;

const Data = struct {
    result: pkmn.Result = pkmn.Result.Default,
    c1: pkmn.Choice = .{},
    c2: pkmn.Choice = .{},
    state: []u8,
    log: []u8 = &.{},
};

var data: ?std.ArrayList(Data) = null;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var fuzz = false;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    if (args.len < 3 or args.len > 5) usageAndExit(args[0], fuzz);

    const gen = std.fmt.parseUnsigned(u8, args[1], 10) catch
        errorAndExit("gen", args[1], args[0], fuzz);
    if (gen < 1 or gen > 8) errorAndExit("gen", args[1], args[0], fuzz);

    var battles: ?usize = null;
    var duration: ?usize = null;
    if (args[2].len > 1 and std.ascii.isAlpha(args[2][args[2].len - 1])) {
        fuzz = true;
        const last = args[2].len - 1;
        const mod: usize = switch (args[2][last]) {
            's' => 1,
            'm' => std.time.s_per_min,
            'h' => std.time.s_per_hour,
            'd' => std.time.s_per_day,
            else => errorAndExit("duration", args[2], args[0], fuzz),
        };
        duration = mod * (std.fmt.parseUnsigned(usize, args[2][0..last], 10) catch
            errorAndExit("duration", args[2], args[0], fuzz)) * std.time.ns_per_s;
    } else {
        battles = std.fmt.parseUnsigned(usize, args[2], 10) catch
            errorAndExit("battles", args[2], args[0], fuzz);
        if (battles.? == 0) errorAndExit("battles", args[2], args[0], fuzz);
    }
    const seed = if (args.len > 3) std.fmt.parseUnsigned(u64, args[3], 10) catch
        errorAndExit("seed", args[3], args[0], fuzz) else seed: {
        var secret: [std.rand.DefaultCsprng.secret_seed_length]u8 = undefined;
        std.crypto.random.bytes(&secret);
        var csprng = std.rand.DefaultCsprng.init(secret);
        const random = csprng.random();
        break :seed random.int(usize);
    };
    const playouts = if (args.len == 5) std.fmt.parseUnsigned(usize, args[4], 10) catch
        errorAndExit("playouts", args[4], args[0], fuzz) else null;

    try benchmark(allocator, gen, seed, battles, playouts, duration);
}

pub fn benchmark(
    allocator: Allocator,
    gen: u8,
    seed: u64,
    battles: ?usize,
    playouts: ?usize,
    duration: ?usize,
) !void {
    std.debug.assert(gen >= 1 and gen <= 8);

    const save = duration != null and pkmn.options.trace;

    var random = pkmn.PSRNG.init(seed);
    var options: [pkmn.OPTIONS_SIZE]pkmn.Choice = undefined;

    var time: u64 = 0;
    var turns: usize = 0;
    var elapsed = try Timer.start();

    var out = std.io.getStdOut().writer();
    var err = std.io.getStdErr().writer();

    var i: usize = 0;
    var n = battles orelse std.math.maxInt(usize);
    while (i < n and (if (duration) |d| elapsed.read() < d else true)) : (i += 1) {
        if (duration != null) try err.print("{d}: {d}\n", .{ i, random.src.seed });

        var original = switch (gen) {
            1 => pkmn.gen1.helpers.Battle.random(&random),
            else => unreachable,
        };

        var buf: ?std.ArrayList(u8) = null;
        var log: ?pkmn.Log(std.ArrayList(u8).Writer) = null;
        if (save) {
            if (data != null) deinit(allocator);
            data = std.ArrayList(Data).init(allocator);
            buf = std.ArrayList(u8).init(allocator);
            log = pkmn.Log(std.ArrayList(u8).Writer){ .writer = buf.?.writer() };
        }

        var j: usize = 0;
        var m = playouts orelse 1;
        while (j < m and (if (duration) |d| elapsed.read() < d else true)) : (j += 1) {
            var battle = original;
            std.debug.assert(battle.side(.P1).get(1).hp > 0);
            std.debug.assert(battle.side(.P2).get(1).hp > 0);

            var c1 = pkmn.Choice{};
            var c2 = pkmn.Choice{};

            var p1 = pkmn.PSRNG.init(random.newSeed());
            var p2 = pkmn.PSRNG.init(random.newSeed());

            var timer = try Timer.start();

            var result = try battle.update(c1, c2, log);
            while (result.type == .None) : (result = try battle.update(c1, c2, log)) {
                c1 = options[p1.range(u8, 0, battle.choices(.P1, result.p1, &options))];
                c2 = options[p2.range(u8, 0, battle.choices(.P2, result.p2, &options))];

                if (save) {
                    try data.?.append(.{
                        .result = result,
                        .c1 = c1,
                        .c2 = c2,
                        .state = try allocator.dupe(u8, std.mem.toBytes(battle)[0..]),
                        .log = buf.?.toOwnedSlice(),
                    });
                }
            }
            time += timer.read();
            turns += battle.turn;
        }
    }
    if (data != null) deinit(allocator);
    if (battles != null) try out.print("{d},{d},{d}\n", .{ time, turns, random.src.seed });
}

fn errorAndExit(msg: []const u8, arg: []const u8, cmd: []const u8, fuzz: bool) noreturn {
    const err = std.io.getStdErr().writer();
    err.print("Invalid {s}: {s}\n", .{ msg, arg }) catch {};
    usageAndExit(cmd, fuzz);
}

fn usageAndExit(cmd: []const u8, fuzz: bool) noreturn {
    const err = std.io.getStdErr().writer();
    if (fuzz) {
        err.print("Usage: {s} <GEN> <DURATION> <SEED?>\n", .{cmd}) catch {};
    } else {
        err.print("Usage: {s} <GEN> <BATTLES> <SEED?> <PLAYOUTS?>\n", .{cmd}) catch {};
    }
    std.process.exit(1);
}

fn deinit(allocator: Allocator) void {
    std.debug.assert(data != null);
    for (data.?.items) |d| {
        allocator.free(d.state);
        allocator.free(d.log);
    }
    data.?.deinit();
}

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace) noreturn {
    if (data) |ds| {
        const out = std.io.getStdOut();
        var buf = std.io.bufferedWriter(out.writer());
        var w = buf.writer();
        for (ds.items) |d| {
            w.writeStruct(d.result) catch unreachable;
            w.writeStruct(d.c1) catch unreachable;
            w.writeStruct(d.c2) catch unreachable;
            w.writeAll(d.state) catch unreachable;
            w.writeAll(d.log) catch unreachable;
        }
        buf.flush() catch unreachable;
    }
    std.builtin.default_panic(msg, error_return_trace);
}
