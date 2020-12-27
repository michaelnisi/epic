//
//  PlayerView.swift
//  Epic
//
//  Created by Michael Nisi on 05.09.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI
import Clay

public protocol PlayerHosting {
  func play()
  func forward()
  func backgward()
  func close()
  func pause()
}

@dynamicMemberLookup
public struct PlayerView: View {
  
  public struct Colors {
    public init(base: Color, dark: Color, light: Color) {
      self.base = base
      self.dark = dark
      self.light = light
    }
    
    public let base: Color
    public let dark: Color
    public let light: Color
  }
  
  public let item: PlayerItem
  public let isTransitionAnimating: Bool
  public let colors: Colors
  public let image: Image
  public let airPlayButton: AnyView
  public let delegate: PlayerHosting?
  
  public init(
    item: PlayerItem,
    isTransitionAnimating: Bool,
    colors: Colors,
    image: Image,
    airPlayButton: AnyView,
    delegate: PlayerHosting? = nil
  ) {
    self.item = item
    self.isTransitionAnimating = isTransitionAnimating
    self.colors = colors
    self.image = image
    self.airPlayButton = airPlayButton
    self.delegate = delegate
  }
  
  public subscript<T>(dynamicMember keyPath: KeyPath<PlayerItem, T>) -> T {
    item[keyPath: keyPath]
  }
  
  public func copy(isPlaying: Bool? = nil, isTransitionAnimating: Bool? = nil) -> PlayerView {
    PlayerView(
      item: item.copy(isPlaying: isPlaying),
      isTransitionAnimating: isTransitionAnimating ?? self.isTransitionAnimating,
      colors: colors,
      image: image,
      airPlayButton: airPlayButton,
      delegate: delegate
    )
  }
  
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  @State var trackTime: Double = 20
  @State var imageWidth: CGFloat = 0
  @State var orientation = UIDevice.current.orientation
  
  private var paddingMultiplier: CGFloat {
    horizontalSizeClass == .compact ? 2 / 3 : 1
  }

  private var outerPadding: EdgeInsets {
    EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0)
  }
  
  private var innerPadding: EdgeInsets {
    EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12)
  }
  
  public var body: some View {
    ZStack {
      if !item.isEmpty {
        actualBody
      }
    }
  }
}

// MARK: - Structure

extension PlayerView {
  
  private var closeTap: some Gesture {
    TapGesture()
      .onEnded { _ in
        close()
      }
  }
  
  private var actualBody: some View {
    Group {
      background
      VStack {
        CloseBarButton()
          .gesture(closeTap)
        VStack(spacing: 24) {
          hero
          titles
          track
          controls
          actions
        }
        .padding(innerPadding)
        .foregroundColor(Color.primary)
        .frame(maxWidth: 600)
      }.padding(outerPadding)
    }
  }
}

// MARK: - Background

extension PlayerView {

  var background: some View {
    Background(dark: colors.dark, light: colors.light)
  }
}

// MARK: - Hero Image

extension PlayerView {
  
  private var imageAnimation: Animation? {
    guard !isTransitionAnimating else {
      return nil
    }
    
    return item.isPlaying ? spring : .default
  }
  
  private var spring: Animation {
    .interpolatingSpring(mass: 1, stiffness: 250, damping: 15, initialVelocity: -5)
  }
  
  private var imageShadowRadius: CGFloat {
    (item.isPlaying ? 32 : 16) * paddingMultiplier
  }
  
  private var imagePadding: CGFloat {
    (item.isPlaying ? 8 : 32) * paddingMultiplier
  }
  
  private var hero: some View {
    image
      .resizable()
      .cornerRadius(3)
      .aspectRatio(contentMode: .fit)
      .padding(imagePadding)
      .shadow(radius: imageShadowRadius)
      .frame(maxHeight: .infinity)
      .foregroundColor(Color.secondary)
      .animation(imageAnimation)
      .background(GeometryReader { geometry in
        Color.clear.preference(key: SizePrefKey.self, value: geometry.size)
      })
      .onPreferenceChange(SizePrefKey.self) { size in
        imageWidth = size.width
      }
  }
}

// MARK: - Titles

extension PlayerView {

  private var titles: some View {
    VStack(spacing: 6) {
      MarqueeText(string: item.title, width: $imageWidth)
      Text(item.subtitle)
        .font(.subheadline)
        .lineLimit(1)
    }
  }
}

// MARK: - Track

extension PlayerView {
  
  private var track: some View {
    Clay.Slider(
      value: $trackTime,
      range: (0, 100),
      color: colors.base,
      knobWidth: 0
    ) { modifiers, value, color in
        ZStack {
          ZStack {
            colors.base
              .modifier(modifiers.barLeft)
            Color.gray
              .modifier(modifiers.barRight)
            HStack {
              Text(("\(value)"))
                .font(.body)
                .padding(.leading)
              Spacer()
              Text(("100"))
                .font(.body)
                .padding(.trailing)
            }.foregroundColor(.white)
          }.cornerRadius(.zero)
        }.cornerRadius(15)
      }.frame(height: 30)
  }
}

// MARK: - Controls and Actions

extension PlayerView {
  
  private func nop() {}
  
  private func forward() {
    delegate?.forward()
  }
  
  private func backward() {
    delegate?.backgward()
  }
  
  private func play() {
    delegate?.play()
  }
  
  private func close() {
    delegate?.close()
  }
  
  private func pause() {
    delegate?.pause()
  }
  
  private var controls: some View {
    ControlsView(
      play: play,
      pause: pause,
      forward: forward,
      backward: backward,
      isPlaying: item.isPlaying
    )
  }
  
  private var actions: some View {
    HStack(spacing: 48) {
      PlayerButton(action: nop, style: .moon)
        .frame(width: 20, height: 20 )
      airPlayButton
        .frame(width: 48, height: 48)
      PlayerButton(action: nop, style: .speaker)
        .frame(width: 20, height: 20 )
    }
    .foregroundColor(Color.secondary)
  }
}

// MARK: - Preview

struct PlayerView_Previews: PreviewProvider {
  
  static var previews: some View {
    PlayerView(
      item: item,
      isTransitionAnimating: false,
      colors: colors,
      image: Image("Oval"),
      airPlayButton: AnyView(Button("hello", action: {}))
    )
  }
  
  static var colors: PlayerView.Colors {
    PlayerView.Colors(base: .red, dark: .green, light: .blue)
  }
  
  private static var item: PlayerItem {
    PlayerItem(
      title: "Hello",
      subtitle: "Wow",
      isPlaying: false
    )
  }
}
