//===----------------------------------------------------------------------===//
//
// This source file is part of the Epic open source project
//
// Copyright (c) 2021 Michael Nisi and collaborators
// Licensed under MIT License
//
// See https://github.com/michaelnisi/podest/blob/main/LICENSE for license information
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftUI

struct HeroView: View {
  struct Configuration {
    let padding: CGFloat
    let shadowRadius: CGFloat
  }
  
  @State var conf = Configuration(padding: 0, shadowRadius: 0)
  @ObservedObject var model: Player
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  
  var body: some View {
    ZStack {
      model.image
        .resizable()
        .cornerRadius(5)
        .aspectRatio(contentMode: .fit)
        .padding(conf.padding)
        .shadow(radius: conf.shadowRadius)
        .background(GeometryReader { geometry in
          Color.clear.preference(key: SizePrefKey.self, value: geometry.size)
        })
        .onChange(of: model.isPlaying) { isPlaying in
          withAnimation(imageAnimation) {
            configure(for: isPlaying)
          }
        }
        .onAppear {
          configure(for: model.isPlaying)
        }
    }
  }
}

private extension HeroView {
  var imageAnimation: Animation? {
    model.isPlaying ? spring : .default
  }
 
  var paddingMultiplier: CGFloat {
    horizontalSizeClass == .compact ? 1 : 1.5
  }
  
  var spring: Animation {
    .interpolatingSpring(mass: 1, stiffness: 250, damping: 15, initialVelocity: -5)
  }
  
  func configure(for isPlaying: Bool) {
    conf = .init(
      padding: (isPlaying ? 8 : 40) * paddingMultiplier,
      shadowRadius: (isPlaying ? 32 : 12) * paddingMultiplier
    )
  }
}
