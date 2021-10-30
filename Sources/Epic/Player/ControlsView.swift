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
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  
  private func pauseOrPlay() {
    model.isPlaying ? model.pause() : model.play()
  }
  
  private var forwardColor: Color {
    model.isForwardable ? .primary : model.colors.secondary(matching: colorScheme)
  }
  
  private var backwardColor: Color {
    model.isBackwardable ? .primary : model.colors.secondary(matching: colorScheme)
  }
  
  var body: some View {
    HStack {
      Group {
        PlayerButton(action: model.skipBackward, style: .gobackward15)
          .frame(width: 24, height: 24 )
      }
      .frame(maxWidth: .infinity)
      
      Group {
        PlayerButton(action: model.backward, style: .backward)
          .frame(width: 48, height: 48)
          .disabled(!model.isBackwardable)
          .foregroundColor(backwardColor)
      }
      .frame(maxWidth: .infinity)
      
      Group {
        PlayButton(isPlaying: model.isPlaying, action: pauseOrPlay)
          .frame(width: 48, height: 48)
          .foregroundColor(.primary)
      }
      .frame(maxWidth: .infinity)
      
      Group {
        PlayerButton(action: model.forward, style: .forward)
          .frame(width: 48, height: 64)
          .disabled(!model.isForwardable)
          .foregroundColor(forwardColor)
      }
      .frame(maxWidth: .infinity)
      
      Group {
        PlayerButton(action: model.skipForward, style: .goforward15)
          .frame(width: 24, height: 24)
      }
      .frame(maxWidth: .infinity)
    }
    .frame(maxWidth: .infinity)
  }
}

struct ControlsViewPreview: PreviewProvider {
  static var previews: some View {
    Group {
      ControlsView(model: .init())
    }
  }
}
