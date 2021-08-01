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
