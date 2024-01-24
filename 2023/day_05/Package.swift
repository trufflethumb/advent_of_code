// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Day05",
    products: [
        .library(name: "Day05", targets: ["Day05"]),
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: ["Day05"], resources: [.process("Resources/input.txt")]),
        .target(name: "Day05"),
        .testTarget(name: "Day05Test", dependencies: ["Day05"])
    ]
)
