// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VulnCheckTest",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "git@github.com:apple/swift-argument-parser.git", from: "1.1.2"),
        .package(url: "git@github.com:marmelroy/Zip.git", from: "2.1.0"),
        .package(url: "git@github.com:ShawnMoore/XMLParsing.git", from: "0.0.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "VulnCheckTest",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Zip", package: "zip"),
                .product(name: "XMLParsing", package: "xmlparsing")
            ]),
        .testTarget(
            name: "VulnCheckTestTests",
            dependencies: ["VulnCheckTest"]),
    ]
)
