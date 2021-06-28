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
let domain = PackageConfig(name: "Domain", path: "Sources", dependencies: [common])
let tests = PackageConfig(name: "DomainTests", path: "Tests", dependencies: [domain])

let package = Package(
    name: domain.name,
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: domain.name,
            targets: [domain.name])
    ],
    dependencies: [
        .package(path: common.path)
    ],
    targets: [
        .target(
            name: domain.name,
            dependencies: domain.targetDependencies,
            path: domain.path),
        .testTarget(
            name: tests.name,
            dependencies: tests.targetDependencies,
            path: tests.path,
            resources: [.process("Resources")])
    ]
)
