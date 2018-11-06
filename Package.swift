// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "scrypt",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "scrypt",
            targets: ["scrypt"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
	.package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "0.12.0"))    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CImpl",
            path: "./scrypt",
            sources: ["Cimpl.c", "Cimpl.h"],
            publicHeadersPath: "scrypt/"
        ),
        .target(
            name: "scrypt",
            dependencies: ["CryptoSwift", "CImpl"],
            path: "./scrypt",
            exclude: ["module.modulemap"],
            sources: ["scrypt/Scrypt.swift"],
            publicHeadersPath: "scrypt/"
        ),
//        .testTarget(
//            name: "scryptTests",
//            dependencies: ["scrypt"],
//            sources: ["scryptTests/"]
//        ),
    ],
    swiftLanguageVersions: [.v4, .v4_2]
)
