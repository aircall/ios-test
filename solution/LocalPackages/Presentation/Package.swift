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
let presentation = PackageConfig(name: "Presentation", path: "Sources", dependencies: [common, domain])

let package = Package(
    name: presentation.name,
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: presentation.name,
            targets: [presentation.name])
    ],
    dependencies: [
        .package(path: common.path),
        .package(path: domain.path)
    ],
    targets: [
        .target(
            name: presentation.name,
            dependencies: presentation.targetDependencies,
            path: presentation.path,
            resources: [.process("Resources")])
    ]
)
