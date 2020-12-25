//
//  PlayerView.swift
//  Podest
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
  
  public struct Model {
    public let title: String
    public let subtitle: String
    public let image: UIImage
    public let isPlaying: Bool
    public let isTransitionAnimating: Bool
    
    public init(
      title: String,
      subtitle: String,
      image: UIImage,
      isPlaying: Bool,
      isTransitionAnimating: Bool
    ) {
      self.title = title
      self.subtitle = subtitle
      self.image = image
      self.isPlaying = isPlaying
      self.isTransitionAnimating = isTransitionAnimating
    }
    
    var isEmpty: Bool {
      title == "" && subtitle == ""
    }
    
    var color: UIColor {
      image.averageColor
    }
  }
  
  private let model: Model
  private let delegate: PlayerHosting?
  
  public init(model: Model, delegate: PlayerHosting? = nil) {
    self.model = model
    self.delegate = delegate
  }
  
  public subscript<T>(dynamicMember keyPath: KeyPath<Model, T>) -> T {
    model[keyPath: keyPath]
  }
  
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  @State var trackTime: Double = 0.5
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
      if !model.isEmpty {
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
      Background(image: model.image)
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
        .foregroundColor(Color(.label))
        .frame(maxWidth: 600)
      }.padding(outerPadding)
    }
  }
}

// MARK: - Hero Image

extension PlayerView {
  
  private var imageAnimation: Animation? {
    guard !model.isTransitionAnimating else {
      return nil
    }
    
    return model.isPlaying ? spring : .default
  }
  
  private var spring: Animation {
    .interpolatingSpring(mass: 1, stiffness: 250, damping: 15, initialVelocity: -5)
  }
  
  private var imageShadowRadius: CGFloat {
    (model.isPlaying ? 32 : 16) * paddingMultiplier
  }
  
  private var imagePadding: CGFloat {
    (model.isPlaying ? 8 : 32) * paddingMultiplier
  }
  
  private var hero: some View {
    Image(uiImage: model.image)
      .resizable()
      .cornerRadius(3)
      .aspectRatio(contentMode: .fit)
      .padding(imagePadding)
      .shadow(radius: imageShadowRadius)
      .frame(maxHeight: .infinity)
      .foregroundColor(Color(.quaternaryLabel))
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
      MarqueeText(string: model.title, width: $imageWidth)
      Text(model.subtitle)
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
      color: model.color,
      knobWidth: 0
    ) { modifiers, value, color in
        ZStack {
          ZStack {
            Color(color)
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
      isPlaying: model.isPlaying
    )
  }
  
  private var actions: some View {
    HStack(spacing: 48) {
      PlayerButton(action: nop, style: .moon)
        .frame(width: 20, height: 20 )
      AirPlayButton()
        .frame(width: 48, height: 48)
      PlayerButton(action: nop, style: .speaker)
        .frame(width: 20, height: 20 )
    }
    .foregroundColor(Color(.secondaryLabel))
  }
}
