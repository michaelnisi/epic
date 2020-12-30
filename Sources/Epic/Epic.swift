//
//
//  Epic.swift
//  Epic
//
//  Created by Michael Nisi on 30.12.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI

public protocol PlayerHosting {
  func play()
  func forward()
  func backward()
  func close()
  func pause()
}

public struct PlayerItem {
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
