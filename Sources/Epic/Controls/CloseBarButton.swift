//
//  CloseBarButton.swift
//  Podest
//
//  Created by Michael Nisi on 05.09.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI
//
//#if os(macOS)
//extension Color {
//  var secondary: Color {
//    Color(.secondaryLabelColor)
//  }
//}
//#else
//extension Color {
//  var secondary: Color {
//    Color(.secondaryLabel)
//  }
//}
//#endif

struct CloseBarButton: View {
  var body: some View {
    Rectangle()
      .fill(Color.secondary)
      .frame(width: 96, height: 6)
      .cornerRadius(3)
  }
}

