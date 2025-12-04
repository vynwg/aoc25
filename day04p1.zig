const std = @import("std");
const file = @embedFile("input04.txt");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var f_lines = std.mem.splitAny(u8, file, "\n");
    var arr = std.array_list.Aligned([]const u8, null).empty;

    while (f_lines.next()) |line| {
        std.debug.print("{s}\n", .{line});
        try arr.append(allocator, line);
    }

    var rolls: u64 = 0;
    const lines = arr.items;

    for (lines, 0..) |line, i| {
        if (line.len < 1) continue;

        var count: u8 = 0;

        for (line, 0..) |char, j| {
            if (char != '@') continue;

            if (i > 0) {
                if (lines[i - 1][j] == '@') count += 1;
            }

            if (i < lines.len - 1) {
                if (lines[i + 1][j] == '@') count += 1;
            }

            if (j > 0) {
                if (line[j - 1] == '@') count += 1;
                if (i > 0) {
                    if (lines[i - 1][j - 1] == '@') count += 1;
                }
                if (i < lines.len - 1) {
                    if (lines[i + 1][j - 1] == '@') count += 1;
                }
            }

            if (j < line.len - 1) {
                if (line[j + 1] == '@') count += 1;
                if (i < lines.len - 1) {
                    if (lines[i + 1][j + 1] == '@') count += 1;
                }
                if (i > 0) {
                    if (lines[i - 1][j + 1] == '@') count += 1;
                }
            }

            if (count < 4) rolls += 1;
            count = 0;
        }
    }

    std.debug.print("{}", .{rolls});
}
