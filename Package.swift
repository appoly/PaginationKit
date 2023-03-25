// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaginationKit",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "PaginationKitClient",
            targets: ["PaginationKitClient"]),
        .library(
            name: "PaginationKitServer",
            targets: ["PaginationKitServer"]),
    ],
    targets: [
        .target(
            name: "PaginationKitClient",
            dependencies: [],
            path: "Sources/PaginationKitClient"),
        .target(
            name: "PaginationKitServer",
            dependencies: [],
            path: "Sources/PaginationKitServer"),
        .testTarget(
            name: "PaginationKitClientTests",
            dependencies: ["PaginationKitClient", "PaginationKitServer"]),
        .testTarget(
            name: "PaginationKitServerTests",
            dependencies: ["PaginationKitServer"]),
    ]
)
