//
//  Background.swift
//  Podest
//
//  Created by Michael Nisi on 13.12.20.
//  Copyright © 2020 Michael Nisi. All rights reserved.
//

import SwiftUI

struct Background: View {
  
  let dark: Color
  let light: Color
  
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var color: Color {
    colorScheme == .dark ? dark : light
  }
  
  var body: some View {
    color
      .edgesIgnoringSafeArea(.all)
      .animation(.default)
  }
}
