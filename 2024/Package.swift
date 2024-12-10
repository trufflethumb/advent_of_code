// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let inputFiles = (1...6).map { day in
    Resource.process(String(format: "Resources/input%.2d.txt", day))
}

let package = Package(
    name: "aoc2024",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "aoc2024",
            targets: ["aoc2024"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "aoc2024",
            resources: inputFiles
        ),
        .testTarget(
            name: "aoc2024Tests",
            dependencies: ["aoc2024"]
        ),
    ]
)
