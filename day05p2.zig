const std = @import("std");
const file = @embedFile("input05.txt");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var fresh = std.array_list.Aligned(u64, null).empty;
    defer fresh.deinit(allocator);
    var lines = std.mem.splitAny(u8, file, "\n");

    while (lines.next()) |line| {
        if (line.len < 1) break;

        var idx = std.mem.splitAny(u8, line, "-");
        const start = try std.fmt.parseInt(u64, idx.next().?, 10);
        const end = try std.fmt.parseInt(u64, idx.next().?, 10);
    }

    std.debug.print("{}", .{fresh.items.len});
}
