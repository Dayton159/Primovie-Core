// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Primovie-Core",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(
            name: "Primovie-Core",
            targets: ["Primovie-Core"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.2.0")
    ],
    targets: [
        .target(
            name: "Primovie-Core",
            dependencies: [
              "RxSwift",
              .product(name: "RxCocoa", package: "RxSwift")
            ]),
        .testTarget(
            name: "Primovie-CoreTests",
            dependencies: ["Primovie-Core"]),
    ]
)
