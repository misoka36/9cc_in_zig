const std = @import("std");

pub fn main() !void {
    const alc = std.heap.page_allocator;
    const args = try std.process.argsAlloc(alc);
    defer std.process.argsFree(alc, args);

    if (args.len != 2) {
        std.debug.print("Usage: {s} decimal_numbers ..\n", .{args[0]});
        std.os.exit(1);
    }

    var sum: i32 = 0;
    for (args[1..]) |arg| {
        const num = try std.fmt.parseInt(i32, arg, 10);
        sum += num;
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print(".intel_syntax noprefix\n", .{});
    try stdout.print(".globl main\n", .{});
    try stdout.print("main:\n", .{});
    try stdout.print("  mov rax, {}\n", .{try std.fmt.parseInt(i64, args[1], 10)});
    try stdout.print("  ret\n", .{});
}
