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
  private let base: UIColor
  
  public init(base: UIColor) {
    self.base = base
  }
}

public extension Colors {
  init(image: UIImage) {
    let color = image.averageColor
    base = color.isBlack ? .init(white: 0.4, alpha: 1) : image.averageColor
  }
}

public extension Colors {
  func background(matching scheme: ColorScheme) -> Color {
    switch scheme {
    case .light:
      return Color(base.lighter(0.3))
    case .dark:
      return Color(base.darker(0.3))
    @unknown default:
      return Color(base.lighter(0.3))
    }
  }
  
  func secondary(matching scheme: ColorScheme) -> Color {
    switch scheme {
    case .light:
      return Color(base)
    case .dark:
      return Color(base)
    @unknown default:
      return Color(base)
    }
  }
  
  func primary(matching scheme: ColorScheme) -> Color {
    switch scheme {
    case .light:
      return Color(base.darker(0.3))
    case .dark:
      return Color(base.lighter(0.3))
    @unknown default:
      return Color(base.darker(0.3))
    }
  }
}

struct ColorsKey: EnvironmentKey {
  static var defaultValue = Colors(base: .gray)
}

public extension EnvironmentValues {
  var colors: Colors {
    get { self[ColorsKey.self] }
    set { self[ColorsKey.self] = newValue }
  }
}

private extension UIColor {
  var isBlack: Bool {
    let white = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
    
    defer {
      white.deallocate()
    }
    getWhite(white, alpha: nil)
    
    return white.pointee < 0.2
  }
}
