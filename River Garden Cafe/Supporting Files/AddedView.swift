//
//  AddedView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 13/02/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct AddedView: View {
    var body: some View {
        ZStack {
            
            BlurView()
            
            VStack {
                Image(systemName: "tray.and.arrow.down.fill")
                    .font(.largeTitle)
                Text("Added")
                    .padding(.top, 8)
            }
            .foregroundColor(.primary)
        }
        .frame(width: 110, height: 110)
        .cornerRadius(10)
    }
}

struct BlurView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}

struct AddedView_Previews: PreviewProvider {
    static var previews: some View {
        AddedView()
    }
}
