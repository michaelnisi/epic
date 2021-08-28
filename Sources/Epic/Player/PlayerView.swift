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
  private let airPlayButton: AnyView
  
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  
  @StateObject private var title = MarqueeText.Model(string: "", width: .zero)
  @State private var imageConfiguration: (CGFloat, CGFloat) = (40, 12)
  
  public init(model: Player, airPlayButton: AnyView) {
    self.model = model
    self.airPlayButton = airPlayButton
  }
  
  private var secondaryColor: Color {
    colorScheme == .dark ? model.colors.light : model.colors.dark
  }
  
  private var paddingMultiplier: CGFloat {
    horizontalSizeClass == .compact ? 1 : 1.5
  }

  private var outerPadding: EdgeInsets {
    EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
  }
  
  private var innerPadding: EdgeInsets {
    EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12)
  }
  
  public var body: some View {
    ZStack {
      root
    }
  }
}

// MARK: - Structure

extension PlayerView {
  private var root: some View {
    Group {
      background
        .edgesIgnoringSafeArea(.all)
        .animation(.default)
      VStack {
        CloseBarButton {
          model.close()
        }
        .foregroundColor(.secondary)
        VStack(spacing: 24) {
          hero
          titles 
          TrackView(colors: model.colors, track: model.track, textColor: background)
          controls
          actions
        }
        .padding(innerPadding)
        .foregroundColor(Color.primary)
        .frame(maxWidth: 600)
      }
      .padding(outerPadding)
    }
  }
}

// MARK: - Background

extension PlayerView {
  var background: Color {
    colorScheme == .dark ? model.colors.dark : model.colors.light
  }
}

// MARK: - Hero Image

extension PlayerView {
  private var imageAnimation: Animation? {
    model.isPlaying ? spring : .default
  }
  
  private var spring: Animation {
    .interpolatingSpring(mass: 1, stiffness: 250, damping: 15, initialVelocity: -5)
  }
  
  private func adjustImage(matching isPlaying: Bool) {
    imageConfiguration = (
      (isPlaying ? 8 : 40) * paddingMultiplier,
      (isPlaying ? 32 : 12) * paddingMultiplier
    )
  }
  
  private var hero: some View {
    model.image
      .resizable()
      .cornerRadius(5)
      .aspectRatio(contentMode: .fit)
      .padding(imageConfiguration.0)
      .shadow(radius: imageConfiguration.1)
      .frame(maxHeight: .infinity)
      .background(GeometryReader { geometry in
        Color.clear.preference(key: SizePrefKey.self, value: geometry.size)
      })
      .onPreferenceChange(SizePrefKey.self) { size in
        title.string = model.title
        title.width = size.width
      }
      .onChange(of: model.isPlaying) { isPlaying in
        withAnimation(imageAnimation) {
          adjustImage(matching: isPlaying)
        }
      }
      .onAppear {
        adjustImage(matching: model.isPlaying)
      }
  }
}

// MARK: - Titles

extension PlayerView {
  private var titles: some View {
    VStack(spacing: 6) {
      MarqueeText(model: title)
      Text(model.subtitle)
        .font(.subheadline)
        .lineLimit(1)
    }
    .onChange(of: model.title) { string in
      title.string = string
    }
  }
}

// MARK: - Controls and Actions

extension PlayerView {
  private func nop() {}
  
  private var controls: some View {
    ControlsView(model: model)
      .foregroundColor(secondaryColor)
  }
  
  private var actions: some View {
    HStack(spacing: 48) {
      PlayerButton(action: nop, style: .moon)
        .frame(width: 20, height: 20)
      airPlayButton
        .frame(width: 48, height: 48)
        .environment(\.colors, model.colors)
      PlayerButton(action: nop, style: .speaker)
        .frame(width: 20, height: 20)
    }
    .foregroundColor(secondaryColor)
  }
}

