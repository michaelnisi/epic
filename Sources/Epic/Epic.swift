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

public enum PlaybackState {
  case preparing, paused, playing
}

extension Double {
  static let durationFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.minute, .second]
    formatter.zeroFormattingBehavior = [.pad]
    
    return formatter
  }()
  
  var durationString: String {
    guard isFinite && !isNaN else {
      return "00:00"
    }
    
    return Double.durationFormatter.string(from: self) ?? "00:00"
  }
}
