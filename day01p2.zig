const std = @import("std");
const file = @embedFile("input01.txt");

pub fn main() !void {
    var pos: i32 = 50;
    var lines = std.mem.splitAny(u8, file, "\n");
    var password: i32 = 0;

    while (lines.next()) |line| {
        std.debug.print("{s}\n", .{line});

        if (line.len < 1) continue;

        var n = try std.fmt.parseInt(i32, line[1..], 10);

        if (std.mem.startsWith(u8, line, "R")) {
            while (n > 0) {
                n -= 1;
                pos += 1;
                if (pos > 99) {
                    pos = 0;
                }
                if (pos == 0) {
                    password += 1;
                }
            }
        } else {
            while (n > 0) {
                n -= 1;
                pos -= 1;
                if (pos < 0) {
                    pos = 99;
                }
                if (pos == 0) {
                    password += 1;
                }
            }
        }
    }

    std.debug.print("{}", .{password});
}
