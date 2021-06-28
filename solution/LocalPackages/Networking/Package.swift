// swift-tools-version:5.3

import PackageDescription

struct PackageConfig {
    let name: String
    let path: String
    let dependencies: [PackageConfig]
    var targetDependencies: [Target.Dependency] {
        dependencies.map { $0.name }.map(Target.Dependency.init)
    }
}

let common = PackageConfig(name: "Common", path: "../Common", dependencies: [])
let networking = PackageConfig(name: "Networking", path: "Sources", dependencies: [common])
let tests = PackageConfig(name: "NetworkingTests", path: "Tests", dependencies: [networking])

let package = Package(
    name: networking.name,
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: networking.name,
            targets: [networking.name])
    ],
    dependencies: [
        .package(path: common.path)
    ],
    targets: [
        .target(
            name: networking.name,
            dependencies: networking.targetDependencies,
            path: networking.path,
            resources: [.process("Resources")]),
        .testTarget(
            name: tests.name,
            dependencies: tests.targetDependencies,
            path: tests.path,
            resources: [.process("Resources")])
    ]
)
