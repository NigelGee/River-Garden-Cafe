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
                    ZStack {
                    MapView(deltaSpan: 0.001)
                        .frame(height: 180)
                        .accessibilityElement(children: .ignore)
                    
                    InfoImageView()
                        .offset(y: 85)
                    }
                    .padding(.bottom, 85)
                    Group {
                        Text("RIVER GARDENS CAFE")
                            .font(.title)
                            .fontWeight(.light)
                            .padding(.horizontal)
                        
                        Text("Unit 2 River Gardens Walk")
                        
                        Text("Greenwich, London, SE10 0FZ")
                            .padding(.bottom)
                        Text("Monday to Friday 7:30am - 7pm")
                        Text("Saturday and Sunday 8:30am - 7pm")
                        
                        Text("Situated on the River Thames along from Greenwich Cutty Sark, with stunning views of London from the full length windows while serving a variety of hot and cold drink. From specialty coffee to wide range of tea (and wine and beer). Also can enjoy a wide range of cakes & pasties to main meals. (Vegan friendly). Children and dogs friendly (not to eat!)")
                        .padding()
                            
                        
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
