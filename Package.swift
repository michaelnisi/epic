// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Epic",
  platforms: [
    .iOS(.v14), .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "Epic",
      targets: ["Epic"]),
  ],
  dependencies: [
    .package(name: "Clay", path: "/Users/michael/swift/clay")
  ],
  targets: [
    .target(
      name: "Epic",
      dependencies: ["Clay"]),
    .testTarget(
      name: "EpicTests",
      dependencies: ["Epic"]),
  ]
)
