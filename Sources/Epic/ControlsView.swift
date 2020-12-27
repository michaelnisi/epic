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
  
  var body: some View {
      HStack(spacing: 32) {
        PlayerButton(action: forward, style: .gobackward15)
          .frame(width: 24, height: 24 )
          .foregroundColor(Color.secondary)
        PlayerButton(action: backward, style: .backward)
          .frame(width: 48, height: 48)
        PlayButton(isPlaying: isPlaying, action: {
          isPlaying ? pause() : play()
        })
          .frame(width: 48, height: 48)
        PlayerButton(action: forward, style: .forward)
          .frame(width: 48, height: 64)
        PlayerButton(action: forward, style: .goforward15)
          .frame(width: 24, height: 24 )
          .foregroundColor(Color.secondary)
      }
  }
}
