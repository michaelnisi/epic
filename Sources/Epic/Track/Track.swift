//===----------------------------------------------------------------------===//
//
// This source file is part of the Epic open source project
//
// Copyright (c) 2021 Michael Nisi and collaborators
// Licensed under MIT License
//
// See https://github.com/michaelnisi/podest/blob/main/LICENSE for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI

class Track: ObservableObject {
  @Published public var time = Double(0)
  @Published public var dragTime = Double(0)
  @Published private (set) var duration = Double(0)
  
  private var timer: Timer?
}

private extension Track {
  func advanceTime() {
    time = min(time + 0.1, duration)
  }
  
  func startTimer() {
    timer?.invalidate()
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
      self?.advanceTime()
    }
  }
  
  func stopTimer() {
    timer?.invalidate()
    
    timer = nil
  }
}

extension Track {
  func configure(time: Double, duration: Double, isPlaying: Bool) {
    withAnimation(.easeInOut) { [weak self] in
      self?.time = time
      self?.duration = duration
    }
    
    isPlaying ? startTimer() : stopTimer()
  }
}
