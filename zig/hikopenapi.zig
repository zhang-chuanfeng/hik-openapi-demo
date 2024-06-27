const std = @import("std");
const c = @cImport({
    @cInclude("HttpUtil.h");
});

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) @panic("memory leak");
    }
    const gpa_allocator = gpa.allocator();
    const stdout = std.io.getStdOut().writer();

    var args = std.process.args();
    _ = args.next();
    var url = std.ArrayList(u8).init(gpa_allocator);
    defer url.deinit();
    try url.appendSlice("https://10.188.0.101:443/artemis/api/");
    try url.appendSlice(args.next() orelse "");

    var body = std.ArrayList(u8).init(gpa_allocator);
    defer body.deinit();
    try body.appendSlice(args.next() orelse "");

    const appkey = "26395532";
    const secret = "mDXrfXuGRzNW0aqUkzgD";
    var len: c_int = 0;
    try stdout.print("url:{s}\n", .{url.items});
    try stdout.print("body:{s}\n", .{body.items});
    const data = c.HTTPUTIL_Post(url.items.ptr, body.items.ptr, appkey, secret, 15, &len);
    if (data == null) {
        try stdout.print("post fail.err {d}\n", .{c.HTTPUTIL_GetLastStatus()});
        return;
    }
    try stdout.print("{s}\n", .{data[0..@intCast(len)]});
    _ = c.HTTPUTIL_Free(data);
}
