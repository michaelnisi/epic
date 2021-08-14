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
  @ObservedObject var model: Player
  
  private func pauseOrPlay() {
    model.isPlaying ? model.pause() : model.play()
  }
  
  private var forwardColor: Color {
    model.isForwardable ? .primary : model.colors.base
  }
  
  private var backwardColor: Color {
    model.isBackwardable ? .primary : model.colors.base
  }
  
  var body: some View {
      HStack(spacing: 32) {
        PlayerButton(action: model.forward, style: .gobackward15)
          .frame(width: 24, height: 24 )
        PlayerButton(action: model.backward, style: .backward)
          .frame(width: 48, height: 48)
          .disabled(!model.isBackwardable)
          .foregroundColor(backwardColor)
        PlayButton(isPlaying: model.isPlaying, action: pauseOrPlay)
          .frame(width: 48, height: 48)
          .foregroundColor(.primary)
        PlayerButton(action: model.forward, style: .forward)
          .frame(width: 48, height: 64)
          .disabled(!model.isForwardable)
          .foregroundColor(forwardColor)
        PlayerButton(action: model.forward, style: .goforward15)
          .frame(width: 24, height: 24 )
      }
  }
}
