// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Day10",
    products: [
        .library(name: "Day10", targets: ["Day10"]),
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: ["Day10"], resources: [.process("Resources/input.txt")]),
        .target(name: "Day10"),
        .testTarget(name: "Day10Test", dependencies: ["Day10"])
    ]
)
