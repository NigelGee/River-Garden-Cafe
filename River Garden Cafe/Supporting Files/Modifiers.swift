//
//  Modifiers.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct Buttons: ViewModifier {
    var colour: Color
    
    func body(content: Content) -> some View{
        content
            .foregroundColor(.white)
            .frame(width: 160, height: 50)
            .background(colour)
            .clipShape(Capsule())
            .padding(.top)
    }
}

extension View {
    func buttonStyle(colour: Color) -> some View {
        self.modifier(Buttons(colour: colour))
    }
}
