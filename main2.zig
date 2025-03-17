const builtin = @import("builtin");
const root = @import("root");

const main = @import("src/main.zig");

pub const ThreadPool = main.ThreadPool;
pub const stream = main.stream;

pub const BackendOptions = struct {
    linux_backend: main.Backend = .epoll,
};

pub const options: BackendOptions = if (@hasDecl(root, "xev_options")) root.xev_options else .{};

const default: main.Backend = switch (builtin.os.tag) {
    .ios, .macos => .kqueue,
    .linux => options.linux_backend,
    .wasi => .wasi_poll,
    .windows => .iocp,
    else => @compileError("Unsupported OS"),
};

pub const DynamicXev = @import("src/dynamic.zig").Xev;
pub const Dynamic = DynamicXev(main.Backend.candidates());
