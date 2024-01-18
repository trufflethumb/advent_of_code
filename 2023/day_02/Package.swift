// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Day02",
    products: [
        .library(name: "Day02", targets: ["Day02"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "Run", dependencies: ["Day02"], resources: [.process("Resources/input.txt")]),
        .target(name: "Day02"),
        .testTarget(name: "Day02Test", dependencies: ["Day02"])
    ]
)
