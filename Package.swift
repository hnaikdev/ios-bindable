// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-bindable",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ios-bindable",
            targets: ["ios-bindable"]
        ),
    ],
    targets: [
        .target(
            name: "ios-bindable"
        ),
        .testTarget(
            name: "ios-bindableTests",
            dependencies: ["ios-bindable"]
        ),
    ]
)
