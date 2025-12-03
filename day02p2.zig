const std = @import("std");
const file = @embedFile("input02test.txt");

pub fn main() !void {
    var lines = std.mem.splitAny(u8, file, "\n");
    var ranges = std.mem.splitAny(u8, lines.next().?, ",");
    var sum: u64 = 0;

    while (ranges.next()) |range| {
        std.debug.print("{s}\n", .{range});

        if (range.len < 1) continue;

        var idx = std.mem.splitAny(u8, range, "-");
        const i = try std.fmt.parseInt(u64, idx.next().?, 10);
        const end = try std.fmt.parseInt(u64, idx.next().?, 10);

        for (i..end) |n| {}
    }

    std.debug.print("{}", .{sum});
}
