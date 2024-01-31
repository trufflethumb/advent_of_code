// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Day06",
    products: [
        .library(name: "Day06", targets: ["Day06"]),
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: ["Day06"], resources: [.process("Resources/input.txt")]),
        .target(name: "Day06"),
        .testTarget(name: "Day06Test", dependencies: ["Day06"])
    ]
)
