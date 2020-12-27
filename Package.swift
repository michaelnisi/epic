// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Epic",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "Epic",
      targets: ["Epic"]),
  ],
  dependencies: [
    .package(name: "Clay", url: "https://github.com/michaelnisi/clay", from: "1.0.0")
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
