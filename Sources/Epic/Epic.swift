//
//
//  Epic.swift
//  Epic
//
//  Created by Michael Nisi on 30.12.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI

public enum PlaybackState {
  case preparing, paused, playing
}

@dynamicMemberLookup
public class Player: ObservableObject {
  public enum Action {
    case play, forward, backward, close, pause
  }
  
  public struct Item {
    public let title: String
    public let subtitle: String
    public let colors: Colors
    public let image: Image
    
    public init(title: String, subtitle: String, colors: Colors, image: Image) {
      self.title = title
      self.subtitle = subtitle
      self.colors = colors
      self.image = image
    }
  }
  
  @Published public var item = Item()
  @Published public var isPlaying = false
  @Published public var isForwardable = false
  @Published public var isBackwardable = false
  @Published public var trackTime = 0.0
  
  public var actionHandler: ((Action) -> Void)?
  
  public init() {}
  
  public subscript<T>(dynamicMember keyPath: KeyPath<Item, T>) -> T {
    item[keyPath: keyPath]
  }
}

extension Player.Item {
  init() {
    title = ""
    subtitle = ""
    colors = Colors(base: .red, dark: .green, light: .blue)
    image = Image("Oval")
  }
}

public extension Player {
  func configure(
    item: Item,
    isPlaying: Bool,
    isForwardable: Bool,
    isBackwardable: Bool,
    trackTime: Double
  ) {
    self.item = item
    self.isPlaying = isPlaying
    self.isForwardable = isForwardable
    self.isBackwardable = isBackwardable
    self.trackTime = trackTime
  }
}

public extension Player {
  func forward() {
    actionHandler?(.forward)
  }
  
  func backward() {
    actionHandler?(.backward)
  }
  
  func play() {
    actionHandler?(.play)
  }
  
  func close() {
    actionHandler?(.close)
  }
  
  func pause() {
    actionHandler?(.pause)
  }
}
