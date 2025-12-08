const std = @import("std");
const file = @embedFile("input06.txt");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var hor = std.array_list.Aligned(std.array_list.Aligned(u16, null), null).empty;
    defer hor.deinit(allocator);

    var lines = std.mem.splitAny(u8, file, "\n");
    var sum: u64 = 0;

    while (lines.next()) |line| {
        if (!std.mem.containsAtLeast(u8, line, 1, "+")) {
            var num = std.mem.splitAny(u8, line, " ");
            var nums = std.array_list.Aligned(u16, null).empty;

            while (num.next()) |n| {
                if (n.len < 1) continue;
                const s = try std.fmt.parseInt(u16, n, 10);
                try nums.append(allocator, s);
            }

            try hor.append(allocator, nums);
        } else {
            var ops = std.mem.splitAny(u8, line, " ");
            var j: u16 = 0;
            while (ops.next()) |n| {
                if (n.len < 1) continue;
                var tot: u64 = 0;

                if (std.mem.eql(u8, n, "*")) {
                    tot = 1;
                    for (hor.items) |l| {
                        tot *= l.items[j];
                    }
                } else if (std.mem.eql(u8, n, "+")) {
                    for (hor.items) |l| {
                        tot += l.items[j];
                    }
                } else {
                    std.debug.print("AAAAAAAAAAAAAAAAAAAAAA {s}\n", .{n});
                }

                sum += tot;
                j += 1;
            }
        }
    }

    std.debug.print("{}", .{sum});
}
