//
//  StampView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct StampView: View {
    var body: some View {
       Image("logo").resizable()
       .frame(width: 65, height: 65)
       .clipShape(Circle())
       .shadow(radius: 10)
       .shadow(radius: 10)
       .shadow(radius: 10)
    }
}

struct StampView_Previews: PreviewProvider {
    static var previews: some View {
        StampView()
    }
}
