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

/// A view that displays a single line of text, animating it horizontally, like a pendulum, if provided with insufficient space.
struct MarqueeText: View {
  
  class Model: ObservableObject {
    @Published public var string: String
    @Published public var width: CGFloat
    
    init(string: String, width: CGFloat) {
      self.string = string
      self.width = width
    }
  }
  
  @ObservedObject var model: Model
  
  @State private var offset: CGFloat = .zero
  @State private var multiplier: CGFloat = 1
  
  private let space: CGFloat = 24

  private var stringWidth: CGFloat {
    model.string.size(usingFont: .preferredFont(forTextStyle: .headline)).width + space
  }
  
  private var shouldAnimate: Bool {
    stringWidth - space > model.width
  }
  
  private func updateOffset() {
    guard shouldAnimate else {
      offset = 0
      return
    }
    
    offset = (stringWidth - model.width) / 2 * multiplier
  }
  
  private func flipDirection() {
    multiplier *= -1
  }
  
  private var duration: Double {
    shouldAnimate ? min(18, max(9, Double(stringWidth) * 0.03)) : 0
  }
  
  private func update() {
    guard model.width > 0 else {
      return
    }
    
    withAnimation(.linear(duration: duration)) {
      updateOffset()
    }
  }
  
  private func start() {
    multiplier = 1
    update()
  }
  
  public var body: some View {
    ZStack {
      Text(model.string)
        .lineLimit(1)
        .font(.headline)
        .fixedSize()
        .frame(width: model.width)
        .offset(x: offset)
        .clipped()
        .onAnimationComplete(for: offset) {
          flipDirection()
          update()
        }
    }
    .onChange(of: model.string) { _ in
      start()
    }
    .onChange(of: model.width) { _ in
      start()
    }
  }
}

struct SizePrefKey: PreferenceKey {
  
  static var defaultValue: CGSize = .zero
  
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

private extension String {
  
  func size(usingFont font: UIFont) -> CGSize {
    size(withAttributes: [NSAttributedString.Key.font: font])
  }
}

