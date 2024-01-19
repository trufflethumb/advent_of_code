// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Day03",
    products: [
        .library(name: "Day03", targets: ["Day03"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "Run", dependencies: ["Day03"], resources: [.process("Resources/input.txt")]),
        .target(name: "Day03"),
        .testTarget(name: "Day03Test", dependencies: ["Day03"])
    ]
)
