//
//  Colors.swift
//  Epic
//
//  Created by Michael Nisi on 13.12.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI

public struct Colors {
  
  public let base: Color
  public let dark: Color
  public let light: Color
  
  public init(base: Color, dark: Color, light: Color) {
    self.base = base
    self.dark = dark
    self.light = light
  }
}

struct ColorsKey: EnvironmentKey {
  static var defaultValue = Colors(base: .gray, dark: .black, light: .white)
}

extension EnvironmentValues {
  
  public var colors: Colors {
    get { self[ColorsKey.self] }
    set { self[ColorsKey.self] = newValue }
  }
}
