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
  @ObservedObject var model: Player
  
  private var barLeft: Color {
    colorScheme == .dark ? model.colors.base : model.colors.dark
  }
  
  private var barRight: Color {
    colorScheme == .dark ? model.colors.light : model.colors.base
  }
  
  let textColor: Color
  
  var body: some View {
    Clay.Slider(
      value: $model.trackTime,
      range: (0, 100),
      knobWidth: 0
    ) { modifiers, value in
      ZStack {
        ZStack {
          barLeft
            .modifier(modifiers.barLeft)
          barRight
            .modifier(modifiers.barRight)
          HStack {
            Text(("\(value)"))
              .font(.body)
              .padding(.leading)
              .foregroundColor(.white)
            Spacer()
            Text(("100"))
              .font(.body)
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
