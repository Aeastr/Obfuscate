//
//  Package.swift
//  Obfuscate
//
//  Created by Seb Vidal on 23/04/2025.
//

// swift-tools-version: 6.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Obfuscate",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
        .macOS(.v10_15),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "Obfuscate",
            targets: ["Obfuscate"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-syntax", "600.0.0"..<"603.0.0")
        ),
    ],
    targets: [
        .target(
            name: "Obfuscate",
            dependencies: ["ObfuscateMacro"]
        ),
        .macro(
            name: "ObfuscateMacro",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        )
    ]
)
