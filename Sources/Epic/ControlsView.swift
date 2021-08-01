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

import SwiftUI

struct ControlsView: View {
  
  let play: () -> Void
  let pause: () -> Void
  let forward: () -> Void
  let backward: () -> Void
  
  let isPlaying: Bool
  let isBackwardable: Bool
  let isForwardable: Bool
  
  @Environment(\.colors) var colors: Colors
  
  private func pauseOrPlay() {
    isPlaying ? pause() : play()
  }
  
  private var forwardColor: Color {
    isForwardable ? .primary : colors.base
  }
  
  private var backwardColor: Color {
    isBackwardable ? .primary : colors.base
  }
  
  var body: some View {
      HStack(spacing: 32) {
        PlayerButton(action: forward, style: .gobackward15)
          .frame(width: 24, height: 24 )
        PlayerButton(action: backward, style: .backward)
          .frame(width: 48, height: 48)
          .disabled(!isBackwardable)
          .foregroundColor(backwardColor)
        PlayButton(isPlaying: isPlaying, action: pauseOrPlay)
          .frame(width: 48, height: 48)
          .foregroundColor(.primary)
        PlayerButton(action: forward, style: .forward)
          .frame(width: 48, height: 64)
          .disabled(!isForwardable)
          .foregroundColor(forwardColor)
        PlayerButton(action: forward, style: .goforward15)
          .frame(width: 24, height: 24 )
      }
  }
}
