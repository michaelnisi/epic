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

struct ImageButtonStyle: ButtonStyle {
  let systemName: String

  func makeBody(configuration: Self.Configuration) -> some View {
    Image(systemName: systemName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
  }
}

struct PlayButton: View {
  let isPlaying: Bool
  let action: () -> Void
  
  var style: ImageButtonStyle {
    ImageButtonStyle(systemName: isPlaying ? "pause.fill" : "play.fill")
  }
  
  var insets: EdgeInsets {
    EdgeInsets(top: 0, leading: isPlaying ? 0 : 8, bottom: 0, trailing: 0)
  }

  var body: some View {
    Button(action: action) {}
    .buttonStyle(style)
    .padding(insets)
  }
}

struct PlayerButton: View {
  enum Style: String {
    case airplay = "airplayaudio"
    case backward = "backward.fill"
    case forward = "forward.fill"
    case goforward15 = "goforward.15"
    case gobackward15 = "gobackward.15"
    case speaker = "speaker.fill"
    case speaker1 = "speaker.1.fill"
    case speaker2 = "speaker.2.fill"
    case speaker3 = "speaker.3.fill"
    case moon = "moon.fill"
    case moonzzz = "moon.zzz.fill"
  }
  
  let action: () -> Void
  let style: Style
  
  var body: some View {
    Button(action: action) {}
      .buttonStyle(ImageButtonStyle(systemName: style.rawValue))
  }
}


