// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RemoteImage",
    platforms: [
        .iOS(.v16), // Match support set by CodeChallenge app target
    ],
    products: [
        .library(
            name: "RemoteImage",
            targets: ["RemoteImage"]
        ),
    ],
    targets: [
        .target(
            name: "RemoteImage"
        ),
    ]
)
