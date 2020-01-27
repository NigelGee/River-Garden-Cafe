//
//  InfoImageView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct InfoImageView: View {
    var body: some View {
        Image(decorative: "logo").resizable() // This to be taken from iCloud dB
        .frame(width: 250, height: 150)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
        
    }
}

struct InfoImageView_Previews: PreviewProvider {
    static var previews: some View {
        InfoImageView()
    }
}
