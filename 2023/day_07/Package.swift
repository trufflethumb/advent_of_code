// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Day07",
    products: [
        .library(name: "Day07", targets: ["Day07"]),
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: ["Day07"], resources: [.process("Resources/input.txt")]),
        .target(name: "Day07"),
        .testTarget(name: "Day07Test", dependencies: ["Day07"])
    ]
)
