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

struct CloseBarButton: View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  let colors: Colors
  
  private var color: Color {
    colors.base
  }
  
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      Rectangle()
        .frame(width: 96, height: 6)
        .cornerRadius(3)
        .foregroundColor(color)
        .offset(y: horizontalSizeClass == .compact ? 0 : 15)
    }
    .frame(height: 40)
  }
}
