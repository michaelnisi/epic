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

public extension Colors {
  init(image: UIImage) {
    let base = image.averageColor
    
    self.init(
      base: Color(base),
      dark: Color(base.darker(0.3)),
      light: Color(base.lighter(0.3))
    )
  }
}

struct ColorsKey: EnvironmentKey {
  static var defaultValue = Colors(base: .gray, dark: .black, light: .white)
}

public extension EnvironmentValues {
  var colors: Colors {
    get { self[ColorsKey.self] }
    set { self[ColorsKey.self] = newValue }
  }
}
