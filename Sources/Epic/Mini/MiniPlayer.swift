//
//  MiniPlayer.swift
//  Podest
//
//  Created by Michael Nisi on 23.05.21.
//  Copyright © 2021 Michael Nisi. All rights reserved.
//

import Foundation
import UIKit

/// MiniPlayer models presentation of the mini player. After this iteration, move into the Epic (player) package.
public class MiniPlayer {
  public enum Action {
    case play
    case pause
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
  
  @Published public private (set) var isPlaying = false
  @Published public private (set) var item = Item(title: "", image: UIImage())
  
  public var actionHandler: ((Action) -> Void)?
}

public extension MiniPlayer {
  func configure(item: Item, isPlaying: Bool) {
    self.item = item
    self.isPlaying = isPlaying
  }
}
