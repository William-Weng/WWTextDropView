// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWTextDropView",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWTextDropView", targets: ["WWTextDropView"]),
    ],
    targets: [
        .target(name: "WWTextDropView", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
