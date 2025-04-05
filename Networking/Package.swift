// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v16), // Match support set by CodeChallenge app target
    ],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
        .library(
            name: "MockNetworking",
            targets: ["MockNetworking"]
        )
    ],
    targets: [
        .target(
            name: "Networking"
        ),
        .target(
            name: "MockNetworking",
            dependencies: ["Networking"]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking",
                "MockNetworking",
            ]
        ),
    ]
)
