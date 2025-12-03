const std = @import("std");
const file = @embedFile("input02.txt");

pub fn main() !void {
    var lines = std.mem.splitAny(u8, file, "\n");
    var ranges = std.mem.splitAny(u8, lines.next().?, ",");
    var sum: u64 = 0;

    while (ranges.next()) |range| {
        std.debug.print("{s}\n", .{range});

        if (range.len < 1) continue;

        var idx = std.mem.splitAny(u8, range, "-");
        var i = try std.fmt.parseInt(u64, idx.next().?, 10);
        const end = try std.fmt.parseInt(u64, idx.next().?, 10);

        while (i <= end) {
            var mag: u64 = std.math.log_int(u64, 10, i) + 1;

            if (mag % 2 != 0) {
                continue;
            } else {
                mag = std.math.pow(u64, 10, mag / 2);
                const upper = @divTrunc(i, mag);
                const lower = i - upper * mag;

                if (upper == lower) {
                    std.debug.print("{} {} {}\n", .{ upper, lower, i });
                    sum += i;
                }
            }

            i += 1;
        }
    }

    std.debug.print("{}", .{sum});
}
