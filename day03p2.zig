const std = @import("std");
const file = @embedFile("input03.txt");
const Tuple = struct { u32, usize };

pub fn main() !void {
    var lines = std.mem.splitAny(u8, file, "\n");
    var sum: u64 = 0;

    while (lines.next()) |line| {
        if (line.len < 1) continue;

        var last = [12]Tuple{ .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 }, .{ 0, 0 } };

        for (0..12) |n| {
            const start = if (n > 0) last[n - 1][1] + 1 else 0;
            const end = line.len - (11 - n);

            for (line[start..end], start..) |char, i| {
                const num = try std.fmt.parseInt(u8, &[_]u8{char}, 10);

                if (num > last[n][0]) {
                    std.debug.print("{},{} ", .{ num, i });
                    last[n][0] = num;
                    last[n][1] = i;
                }
            }

            const num = last[n][0] * std.math.pow(u64, 10, 11 - n);
            std.debug.print("{}\n", .{num});
            sum += num;
        }
    }

    std.debug.print("{}", .{sum});
}
