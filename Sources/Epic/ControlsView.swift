//
//  ControlsView.swift
//  Epic
//
//  Created by Michael Nisi on 05.09.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI

struct ControlsView: View {
  
  let play: () -> Void
  let pause: () -> Void
  let forward: () -> Void
  let backward: () -> Void
  
  let isPlaying: Bool
  let isBackwardable: Bool
  let isForwardable: Bool
  
  private func pauseOrPlay() {
    isPlaying ? pause() : play()
  }
  
  private var forwardColor: Color {
    isForwardable ? .primary : .secondary
  }
  
  private var backwardColor: Color {
    isBackwardable ? .primary : .secondary
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
