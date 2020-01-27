//
//  ContentView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LoyaltyCardView(reader: Reader())
                .tabItem {
                    Image(systemName: "circle.grid.3x3")
                    Text("Loyaty")
            }
            
            InfomationView()
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Info")
            }
            
            OrderView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Order")
            }
            
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
