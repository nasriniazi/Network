// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [.iOS(.v15),.macOS(.v10_12)],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]),
    ],
    dependencies: [.package(url: "https://github.com/nasriniazi/LogManager.git", branch: "main"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1"))
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [.product(name:"LogManager",package:"LogManager"),.product(name: "Alamofire", package: "Alamofire")]),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]),
    ]
)
