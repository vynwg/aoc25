const std = @import("std");
const file = @embedFile("input01.txt");

pub fn main() !void {
    var buff = "";

    for (file) |c| {
        if (c == '\n') {
            std.debug.print("{s}", .{buff});
        } else {
            buff += c;
        }
    }
}
