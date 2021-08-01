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

import Foundation
import UIKit

/// MiniPlayer models presentation of the mini player. After this iteration, move into the Epic (player) package.
public class MiniPlayer {
  public enum Action {
    case play, pause, showPlayer
  }
  
  public struct Item {
    public init(title: String, image: UIImage) {
      self.title = title
      self.image = image
    }
    
    public let title: String
    public let image: UIImage
  }
  
  public init() {
    //
  }
  
  @Published public private (set) var playback: PlaybackState = .preparing
  @Published public private (set) var item = Item(title: "", image: UIImage())
  
  public var actionHandler: ((Action) -> Void)?
}

public extension MiniPlayer {
  func configure(item: Item, playback: PlaybackState) {
    self.item = item
    self.playback = playback
  }
  
  func play() {
    actionHandler?(.play)
  }
  
  func pause() {
    actionHandler?(.pause)
  }
  
  func showPlayer() {
    actionHandler?(.showPlayer)
  }
}
