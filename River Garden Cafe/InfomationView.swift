//
//  InfomationView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct InfomationView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    MapView(deltaSpan: 0.001)
                        .frame(height: 180)
                        .accessibilityElement(children: .ignore)
                    
                    InfoImageView()
                        .offset(y: -85)
                    Group {
                    Text("RIVER GARDENS CAFE")
                        .font(.largeTitle)
                        .fontWeight(.light)
            
                    Text("Unit 2 River Gardens Walk")
                        
                    Text("Greenwich, London, SE10 0FZ")
                        .padding(.bottom)
                        
                    Text("Serving fresh food of passion, Speciality coffee, irresistible cakes & Pastries")
                        .padding()
                    Text("Monday to Friday 7:30am - 7pm")
                    Text("Saturday and Sunday 8:30am - 7pm")
                    }
                    .foregroundColor(.secondary)
                    
                    NavigationLink(destination: WebView(website: "rivergardenscafe.co.uk")) {
                        Text("rivergardenscafe.co.uk")
                            .font(.footnote)
                    }
                    .padding()
                    Spacer()
                }
            }
            .navigationBarTitle("Information", displayMode: .inline)
        }
    }
}

struct InfomationView_Previews: PreviewProvider {
    static var previews: some View {
        InfomationView()
    }
}
