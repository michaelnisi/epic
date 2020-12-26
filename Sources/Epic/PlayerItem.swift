//
//  PlayerItem.swift
//  
//
//  Created by Michael Nisi on 26.12.20.
//

public struct PlayerItem {
  
  public let title: String
  public let subtitle: String
  public let isPlaying: Bool
  
  public init(
    title: String,
    subtitle: String,
    isPlaying: Bool
  ) {
    self.title = title
    self.subtitle = subtitle
    self.isPlaying = isPlaying
  }
  
  var isEmpty: Bool {
    title == "" && subtitle == ""
  }
  
  func copy(title: String? = nil, subtitle: String? = nil, isPlaying: Bool? = nil) -> Self {
    PlayerItem(
      title: title ?? self.title,
      subtitle: subtitle ?? self.subtitle,
      isPlaying: isPlaying ?? self.isPlaying
    )
  }
}
