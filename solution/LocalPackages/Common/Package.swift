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

let common = PackageConfig(name: "Common", path: "Sources", dependencies: [])
let tests = PackageConfig(name: "CommonTests", path: "Tests", dependencies: [common])

let package = Package(
    name: common.name,
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: common.name,
            targets: [common.name])
    ],
    targets: [
        .target(
            name: common.name,
            path: common.path),
        .testTarget(name: tests.name,
                    dependencies: tests.targetDependencies,
                    path: tests.path,
                    resources: [.process("Resources")])
    ]
)
