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
import Clay

struct TrackView: View {
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  
  let colors: Colors
  @ObservedObject var track: Track
  
  private var barLeft: Color {
    colorScheme == .dark ? colors.base : colors.dark
  }
  
  private var barRight: Color {
    colorScheme == .dark ? colors.light : colors.base
  }
  
  let textColor: Color
  
  var body: some View {
    Clay.Slider(
      value: $track.time,
      range: (0, track.duration),
      knobWidth: 0,
      onDragChange: { time in
        track.dragTime = time
      }
    ) { modifiers, value in
      ZStack {
        ZStack {
          barLeft
            .modifier(modifiers.barLeft)
          barRight
            .modifier(modifiers.barRight)
          HStack {
            Text(track.time.durationString)
              .font(.system(.body, design: .monospaced))
              .padding(.leading)
              .foregroundColor(.white)
            Spacer()
            Text(track.duration.durationString)
              .font(.system(.body, design: .monospaced))
              .padding(.trailing)
              .foregroundColor(textColor)
          }
        }
        .cornerRadius(.zero)
      }
      .cornerRadius(15)
    }
    .frame(height: 30)
  }
}
