// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SwiftyExtension",
    platforms: [.iOS(.v13), .macOS(.v10_13)],
    products: [
        .library(
            name: "SwiftyExtension",
            targets: ["SwiftyExtension"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftyExtension",
            path: "Sources",
            exclude: [],
            sources: [
                "Classes/FoundationExtension",
                "Classes/Protocol",
                "Classes/SmallTools/Common",
                "Classes/SmallTools/iOS",
                "Classes/UIKitExtension",
                "Classes/SmallTools/macOS",
                "Classes/AppkitExtension"
            ],
            resources: [.process("Assets/ironman.png")],
            cSettings: [],
            swiftSettings: [],
            linkerSettings: []
        ),
        .testTarget(
            name: "SwiftyExtensionTests",
            dependencies: ["SwiftyExtension"],
            path: "Tests/SwiftyExtensionTests"
        ),
    ]
)
