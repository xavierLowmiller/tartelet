// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VirtualMachine",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "VirtualMachine", targets: ["VirtualMachine"]),
        .library(name: "VirtualMachineEditorService", targets: ["VirtualMachineEditorService"]),
        .library(name: "VirtualMachineFactory", targets: ["VirtualMachineFactory"]),
        .library(name: "VirtualMachineFleet", targets: ["VirtualMachineFleet"]),
        .library(name: "VirtualMachineFleetLive", targets: ["VirtualMachineFleetLive"]),
        .library(name: "VirtualMachineResourcesCopier", targets: ["VirtualMachineResourcesCopier"]),
        .library(name: "VirtualMachineResourcesService", targets: ["VirtualMachineResourcesService"]),
        .library(name: "VirtualMachineResourcesServiceEditor", targets: ["VirtualMachineResourcesServiceEditor"]),
        .library(name: "VirtualMachineResourcesServiceEphemeral", targets: ["VirtualMachineResourcesServiceEphemeral"]),
        .library(name: "VirtualMachineSourceNameRepository", targets: ["VirtualMachineSourceNameRepository"])
    ],
    dependencies: [
        .package(path: "../FileSystem"),
        .package(path: "../GitHub"),
        .package(path: "../Logging")
    ],
    targets: [
        .target(name: "VirtualMachine"),
        .target(name: "VirtualMachineEditorService", dependencies: [
            .product(name: "LogHelpers", package: "Logging"),
            "VirtualMachine",
            "VirtualMachineFactory",
            "VirtualMachineResourcesService"
        ]),
        .target(name: "VirtualMachineFactory", dependencies: [
            "VirtualMachine"
        ]),
        .target(name: "VirtualMachineFleet"),
        .target(name: "VirtualMachineFleetLive", dependencies: [
            "VirtualMachine",
            "VirtualMachineFactory",
            "VirtualMachineFleet",
            .product(name: "LogHelpers", package: "Logging")
        ]),
        .target(name: "VirtualMachineResourcesCopier", dependencies: [
            .product(name: "FileSystem", package: "FileSystem"),
            .product(name: "LogHelpers", package: "Logging")
        ]),
        .target(name: "VirtualMachineResourcesService"),
        .target(name: "VirtualMachineResourcesServiceEditor", dependencies: [
            "VirtualMachineResourcesCopier",
            "VirtualMachineResourcesService",
            .product(name: "FileSystem", package: "FileSystem")
        ], resources: [.copy("Resources")]),
        .target(name: "VirtualMachineResourcesServiceEphemeral", dependencies: [
            "VirtualMachineResourcesCopier",
            "VirtualMachineResourcesService",
            .product(name: "FileSystem", package: "FileSystem"),
            .product(name: "GitHubCredentialsStore", package: "GitHub"),
            .product(name: "GitHubService", package: "GitHub")
        ], resources: [.copy("Resources")]),
        .target(name: "VirtualMachineSourceNameRepository")
    ]
)
