// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Day04",
    products: [
        .library(name: "Day04", targets: ["Day04"]),
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: ["Day04"], resources: [.process("Resources/input.txt")]),
        .target(name: "Day04"),
        .testTarget(name: "Day04Test", dependencies: ["Day04"])
    ]
)