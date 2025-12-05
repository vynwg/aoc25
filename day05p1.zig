const std = @import("std");
const file = @embedFile("input05.txt");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var ranges = std.array_list.Aligned(struct { u64, u64 }, null).empty;

    var lines = std.mem.splitAny(u8, file, "\n");
    var ing_list = false;
    var fresh: u64 = 0;

    while (lines.next()) |line| {
        if (line.len < 1) {
            ing_list = true;
            continue;
        }

        if (ing_list) {
            const num = try std.fmt.parseInt(u64, line, 10);

            for (ranges.items) |range| {
                if (num >= range[0] and num <= range[1]) {
                    fresh += 1;
                    break;
                }
            }
        } else {
            var idx = std.mem.splitAny(u8, line, "-");
            const start = try std.fmt.parseInt(u64, idx.next().?, 10);
            const end = try std.fmt.parseInt(u64, idx.next().?, 10);

            try ranges.append(allocator, .{ start, end });
        }
    }

    std.debug.print("{}", .{fresh});
}
