const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "hikopenapi",
        .root_source_file = .{ .src_path = .{ .owner = b, .sub_path = "hikopenapi.zig" } },
        .target = target,
        .optimize = optimize,
    });
    // #cgo LDFLAGS: -L./lib -Wl,--start-group -lHttpUtil -lhlog -lHCNetUtils -lcrypto -lssl -lhpr -lCsfTraceChain -Wl,-rpath='$ORIGIN' -Wl,--end-group
    exe.addLibraryPath(.{ .src_path = .{ .owner = b, .sub_path = "../public/lib/linux/Release" } });
    exe.addIncludePath(.{ .src_path = .{ .owner = b, .sub_path = "../include" } });
    exe.linkSystemLibrary("HttpUtil");
    exe.linkSystemLibrary("hlog");
    exe.linkSystemLibrary("HCNetUtils");
    exe.linkSystemLibrary("crypto");
    exe.linkSystemLibrary("ssl");
    exe.linkSystemLibrary("hpr");
    exe.linkSystemLibrary("CsfTraceChain");
    exe.linkLibC();
    b.installArtifact(exe);
}
