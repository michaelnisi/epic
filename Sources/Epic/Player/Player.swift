//===----------------------------------------------------------------------===//
//
// This source file is part of the Epic open source project
//
// Copyright (c) 2021 Michael Nisi and collaborators
// Licensed under MIT License
//
// See https://github.com/michaelnisi/podest/blob/main/LICENSE for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import Combine
import CoreMIDI
import simd

@dynamicMemberLookup
public class Player: ObservableObject {
  public enum Action {
    case play, forward, backward, close, pause, scrub(Double)
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
  
  @Published var item = Item()
  @Published var isPlaying = false
  @Published var isForwardable = false
  @Published var isBackwardable = false
  @ObservedObject var track: Track
  public var actionHandler: ((Action) -> Void)?
  private var subscriptons = Set<AnyCancellable>()
  
  public init() {
    track = Track()
    track.$dragTime
      .sink { [unowned self] time in
        self.scrub(time: time)
      }
      .store(in: &subscriptons)
  }
  
  subscript<T>(dynamicMember keyPath: KeyPath<Item, T>) -> T {
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
    trackTime: Double,
    trackDuration: Double
  ) {
    self.item = item
    self.isPlaying = isPlaying
    self.isForwardable = isForwardable
    self.isBackwardable = isBackwardable
  
    track.configure(time: trackTime, duration: trackDuration, isPlaying: isPlaying)
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
  
  func scrub(time: Double) {
    actionHandler?(.scrub(time))
  }
}
