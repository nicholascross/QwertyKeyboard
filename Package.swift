// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QwertyKeyboard",
    platforms: [
       .macOS(.v10_10),
    ],
    products: [
        .library(name: "QwertyKeyboard", targets: ["QwertyKeyboard"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "QwertyKeyboard", dependencies: []),
    ]
)
