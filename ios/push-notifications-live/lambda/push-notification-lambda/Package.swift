// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "push-notification-lambda",
    platforms: [.macOS(.v10_13)],
    products: [
        .executable(
            name: "push-notification-lambda",
            targets: ["push-notification-lambda"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", .upToNextMajor(from: "0.3.0")),
        .package(name: "AWSSDKSwift", url: "https://github.com/soto-project/soto.git", .upToNextMajor(from: "4.7.0"))
    ],
    targets: [
        .target(
            name: "push-notification-lambda",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
                .product(name: "Pinpoint", package: "AWSSDKSwift")
            ]),
        .testTarget(
            name: "push-notification-lambdaTests",
            dependencies: ["push-notification-lambda"]),
    ]
)
