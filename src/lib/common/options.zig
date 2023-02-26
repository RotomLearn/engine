const build_options = @import("pkmn_options");
const root = @import("root");

pub const Options = struct {
    showdown: ?bool = null,
    trace: ?bool = null,
    advance: ?bool = null,
    ebc: ?bool = null,
};

pub const showdown = get("showdown", false);
pub const trace = get("trace", false);
pub const advance = get("advance", true);
pub const ebc = get("ebc", true);

fn get(comptime name: []const u8, default: bool) bool {
    var build_enable: ?bool = null;
    var root_enable: ?bool = null;

    if (@hasDecl(root, "pkmn_options")) {
        root_enable = @field(@as(Options, root.pkmn_options), name);
    }
    if (@hasDecl(build_options, name)) {
        build_enable = @as(?bool, @field(build_options, name));
    }
    if (build_enable != null and root_enable != null) {
        if (build_enable.? != root_enable.?) {
            const r = name ++ " (" ++ (if (root_enable.?) "false" else "true") ++ ")";
            const b = name ++ " (" ++ (if (build_enable.?) "false" else "true") ++ ")";
            @compileError("root decl pkmn_options." ++ r ++ " != build option " ++ b ++ ".");
        }
    }

    return root_enable orelse (build_enable orelse default);
}
