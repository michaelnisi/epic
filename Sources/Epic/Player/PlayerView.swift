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

public struct PlayerView: View {
  @ObservedObject public private (set) var model: Player
  private let actionsView: AnyView
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  @StateObject private var title = MarqueeText.Model(string: "", width: .zero)
  
  public init(model: Player, actionsView: AnyView) {
    self.model = model
    self.actionsView = actionsView
  }
  
  public var body: some View {
    root
  }
}

private extension PlayerView {
  var secondaryColor: Color {
    model.colors.secondary(matching: colorScheme)
  }
  
  var heroPadding: EdgeInsets {
    EdgeInsets(
      top: 30,
      leading: horizontalSizeClass == .compact ? 20 : 40,
      bottom: 30,
      trailing: horizontalSizeClass == .compact ? 20 : 40
    )
  }
}

private extension PlayerView {
  var root: some View {
    ZStack(alignment: .top) {
      background
        .edgesIgnoringSafeArea(.all)
        .animation(.default)
      
      VStack {
        HeroView(model: model)
          .padding(heroPadding)
          .frame(maxWidth: 640)
          .onPreferenceChange(SizePrefKey.self) { size in
            title.string = model.title
            title.width = size.width
          }
        Spacer()
        titles
        Spacer(minLength: 30)
        VStack(spacing: 24) {
          TrackView(colors: model.colors, track: model.track, textColor: background)
            .frame(maxWidth: 600)
          controls
            .frame(maxWidth: 320)

        }
        .layoutPriority(1)
        Spacer(minLength: 30)
        actions
          .frame(maxWidth: 208, maxHeight: 48)
        Spacer()
      }
      .padding(12)
      .padding(.bottom, 24)
      .foregroundColor(.primary)
      
      CloseBarButton(colors: model.colors) {
        model.close()
      }
    }
  }
}

// MARK: - Background

private extension PlayerView {
  var background: Color {
    model.colors.background(matching: colorScheme)
  }
}

// MARK: - Titles

private extension PlayerView {
  var titles: some View {
    VStack(spacing: 6) {
      MarqueeText(model: title)
      Text(model.subtitle)
        .font(.subheadline)
        .lineLimit(1)
    }
    .onTapGesture {
      model.more()
    }
    .onChange(of: model.title) { string in
      title.string = string
    }
  }
}

// MARK: - Controls and Actions

private extension PlayerView {
  var controls: some View {
    ControlsView(model: model)
      .foregroundColor(secondaryColor)
  }
  
  var actions: some View {
    actionsView
      .environment(\.colors, model.colors)
  }
}

// MARK: - Preview

struct PlayerViewPreview: PreviewProvider {
  static var previews: some View {
    Group {
      PlayerView(model: .init(), actionsView: AnyView(Color.green))
    }
  }
}
