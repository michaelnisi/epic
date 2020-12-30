//
//  PlayerView.swift
//  Epic
//
//  Created by Michael Nisi on 05.09.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI
import Clay

public struct PlayerView: View {
  
  @dynamicMemberLookup
  public class Model: ObservableObject {
    @Published public var item: PlayerItem
    @Published public var isPlaying: Bool
    @Published public var isForwardable: Bool
    @Published public var isBackwardable: Bool
    
    public init(
      item: PlayerItem,
      isPlaying: Bool,
      isForwardable: Bool,
      isBackwardable: Bool
    ) {
      self.item = item
      self.isPlaying = isPlaying
      self.isForwardable = isForwardable
      self.isBackwardable = isBackwardable
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<PlayerItem, T>) -> T {
      item[keyPath: keyPath]
    }
  }
  
  @ObservedObject private var model: Model
  private let airPlayButton: AnyView
  private let delegate: PlayerHosting?
  
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  
  @StateObject private var title = MarqueeText.Model(string: "", width: .zero)
  @State private var trackTime: Double = 20
  @State private var imagePadding: CGFloat = 40
  
  public init(model: Model, airPlayButton: AnyView, delegate: PlayerHosting? = nil) {
    self.model = model
    self.airPlayButton = airPlayButton
    self.delegate = delegate
  }
  
  private var secondaryColor: Color {
    colorScheme == .dark ? model.colors.light : model.colors.dark
  }
  
  private var paddingMultiplier: CGFloat {
    horizontalSizeClass == .compact ? 1 : 1.5
  }

  private var outerPadding: EdgeInsets {
    EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0)
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
        closeButton
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

// MARK: - Close Button

extension PlayerView {
  
  private var closeTap: some Gesture {
    TapGesture()
      .onEnded { _ in
        close()
      }
  }
  
  private var closeButton: some View {
    CloseBarButton()
      .gesture(closeTap)
      .foregroundColor(secondaryColor)
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
  
  private var imageShadowRadius: CGFloat {
    (model.isPlaying ? 32 : 12) * paddingMultiplier
  }
  
  private func updateImagePadding(isPlaying: Bool) {
    imagePadding = (isPlaying ? 8 : 40) * paddingMultiplier
  }
  
  private var hero: some View {
    model.image
      .resizable()
      .cornerRadius(15)
      .aspectRatio(contentMode: .fit)
      .padding(imagePadding)
      .shadow(radius: imageShadowRadius)
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
          updateImagePadding(isPlaying: isPlaying)
        }
      }
      .onAppear {
        updateImagePadding(isPlaying: model.isPlaying)
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

// MARK: - Track

extension PlayerView {
  
  private var barLeft: Color {
    colorScheme == .dark ? model.colors.base : model.colors.dark
  }
  
  private var barRight: Color {
    colorScheme == .dark ? model.colors.light : model.colors.base
  }
  
  private var track: some View {
    Clay.Slider(
      value: $trackTime,
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
                .foregroundColor(background)
            }
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
    delegate?.backward()
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
      isPlaying: model.isPlaying,
      isBackwardable: model.isBackwardable,
      isForwardable: model.isForwardable
    )
    .foregroundColor(secondaryColor)
    .environment(\.colors, model.colors)
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

