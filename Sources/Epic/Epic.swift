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

public protocol PlayerHosting {
  func play()
  func forward()
  func backward()
  func close()
  func pause()
}

@dynamicMemberLookup
public class Player: ObservableObject {
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
  
  @Published public var item: Item
  @Published public var isPlaying: Bool
  @Published public var isForwardable: Bool
  @Published public var isBackwardable: Bool
  @Published public var trackTime: Double
  
  public init(
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
  convenience init() {
    self.init(item: Item(), isPlaying: false, isForwardable: false, isBackwardable: false, trackTime: 0)
  }
}
