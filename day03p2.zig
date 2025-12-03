const std = @import("std");
const file = @embedFile("input03.txt");

pub fn main() !void {
    var lines = std.mem.splitAny(u8, file, "\n");
    var sum: u64 = 0;

    while (lines.next()) |line| {
        if (line.len < 1) continue;

        var last: u64 = 0;

        for (line, 0..) |char, i| {
            if (line.len == i + 1) break;

            const n1 = try std.fmt.parseInt(u8, &[_]u8{char}, 10);

            for (line[(i + 1)..]) |char2| {
                const n2 = try std.fmt.parseInt(u8, &[_]u8{char2}, 10);
                const n = n1 * 10 + n2;

                if (n > last) {
                    last = n;
                }
            }
        }

        sum += last;
        last = 0;
    }

    std.debug.print("{}", .{sum});
}
