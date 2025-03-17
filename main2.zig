const builtin = @import("builtin");
const root = @import("root");

const main = @import("src/main.zig");

pub const ThreadPool = main.ThreadPool;
pub const stream = main.stream;

pub const Options = struct {
    linux_backend: main.Backend = .epoll,
};

pub const options: Options = if (@hasDecl(root, "xev_options")) root.xev_options else .{};

const default: main.Backend = switch (builtin.os.tag) {
    .ios, .macos => .kqueue,
    .linux => options.linux_backend,
    .wasi => .wasi_poll,
    .windows => .iocp,
    else => @compileError("Unsupported OS"),
};

const api = default.Api();
pub const dynamic = api.dynamic;
pub const backend = api.backend;
pub const available = api.available;
pub const Loop = api.Loop;
pub const Completion = api.Completion;
pub const Result = api.Result;
pub const ReadBuffer = api.ReadBuffer;
pub const WriteBuffer = api.WriteBuffer;
pub const Options = api.Options;
pub const RunMode = api.RunMode;
pub const CallbackAction = api.CallbackAction;
pub const CompletionState = api.CompletionState;
pub const AcceptError = api.AcceptError;
pub const CancelError = api.CancelError;
pub const CloseError = api.CloseError;
pub const ConnectError = api.ConnectError;
pub const ShutdownError = api.ShutdownError;
pub const WriteError = api.WriteError;
pub const ReadError = api.ReadError;
pub const PollError = api.PollError;
pub const PollEvent = api.PollEvent;
pub const WriteQueue = api.WriteQueue;
pub const WriteRequest = api.WriteRequest;
pub const Async = api.Async;
pub const File = api.File;
pub const Process = api.Process;
pub const Stream = api.Stream;
pub const Timer = api.Timer;
pub const TCP = api.TCP;
pub const UDP = api.UDP;
pub const Callback = api.Callback;
pub const Sys = api.Sys;
