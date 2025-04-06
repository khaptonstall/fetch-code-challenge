// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Recipes",
    platforms: [
        .iOS(.v16), // Match support set by CodeChallenge app target
    ],
    products: [
        .library(
            name: "RecipesUI",
            targets: ["RecipesUI"]
        ),
        .library(
            name: "RecipesAPI",
            targets: ["RecipesAPI"]
        ),
    ],
    dependencies: [
        .package(path: "../Networking"),
        .package(path: "../RemoteImage"),
    ],
    targets: [
        .target(
            name: "RecipesUI",
            dependencies: [
                "RecipesAPI",
                .product(name: "RemoteImage", package: "RemoteImage"),
            ]
        ),
        .target(
            name: "RecipesAPI",
            dependencies: [
                .product(name: "Networking", package: "Networking"),
            ]
        ),
        .testTarget(
            name: "RecipesUITests",
            dependencies: [
                "RecipesUI",
                .product(name: "MockNetworking", package: "Networking"),
            ]
        ),
        .testTarget(
            name: "RecipesAPITests",
            dependencies: [
                "RecipesAPI",
                .product(name: "MockNetworking", package: "Networking"),
            ]
        ),
    ]
)
