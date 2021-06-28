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
let domain = PackageConfig(name: "Domain", path: "../Domain", dependencies: [])
let networking = PackageConfig(name: "Networking", path: "../Networking", dependencies: [])
let data = PackageConfig(name: "Data", path: "Sources", dependencies: [common, domain, networking])
let tests = PackageConfig(name: "DataTests", path: "Tests", dependencies: [data])

let package = Package(
    name: data.name,
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: data.name,
            targets: [data.name])
    ],
    dependencies: [
        .package(path: common.path),
        .package(path: domain.path),
        .package(path: networking.path)
    ],
    targets: [
        .target(
            name: data.name,
            dependencies: data.targetDependencies,
            path: data.path),
        .testTarget(
            name: tests.name,
            dependencies: tests.targetDependencies,
            path: tests.path,
            resources: [.process("Resources")])
    ]
)
