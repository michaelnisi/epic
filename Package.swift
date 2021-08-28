// swift-tools-version:5.3
//===----------------------------------------------------------------------===//
//
// This source file is part of the Epic open source project
//
// Copyright (c) 2021 Michael Nisi and collaborators
// Licensed under MIT License
//
// See https://github.com/michaelnisi/epic/blob/main/LICENSE for license information
//
//===----------------------------------------------------------------------===//

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
