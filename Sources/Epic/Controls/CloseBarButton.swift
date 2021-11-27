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
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
  let colors: Colors
  
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      Rectangle()
        .frame(width: 96, height: 6)
        .cornerRadius(3)
        .foregroundColor(color)
        .offset(y: 10)
    }
    .frame(height: 40)
  }
}

private extension CloseBarButton {
  var color: Color {
    colors.secondary(matching: colorScheme)
  }
}
