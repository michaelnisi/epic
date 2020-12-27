//
//  PlayerItem.swift
//  Epic
//
//  Created by Michael Nisi on 26.12.20.
//

public struct PlayerItem {
  
  public let title: String
  public let subtitle: String
  public let isPlaying: Bool
  public let isBackwardable: Bool
  public let isForwardable: Bool
  
  public init(
    title: String,
    subtitle: String,
    isPlaying: Bool,
    isBackwardable: Bool,
    isForwardable: Bool
  ) {
    self.title = title
    self.subtitle = subtitle
    self.isPlaying = isPlaying
    self.isBackwardable = isBackwardable
    self.isForwardable = isForwardable
  }
  
  var isEmpty: Bool {
    title == "" && subtitle == ""
  }
  
  func copy(
    title: String? = nil,
    subtitle: String? = nil,
    isPlaying: Bool? = nil,
    isBackwardable: Bool? = nil,
    isForwardable: Bool? = nil
  ) -> Self {
    PlayerItem(
      title: title ?? self.title,
      subtitle: subtitle ?? self.subtitle,
      isPlaying: isPlaying ?? self.isPlaying,
      isBackwardable: isBackwardable ?? self.isBackwardable,
      isForwardable: isForwardable ?? self.isForwardable
    )
  }
}
