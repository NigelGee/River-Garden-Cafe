//
//  ContentView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        TabView {
            LoyaltyCardView()
                .tabItem {
                    Image(systemName: "circle.grid.3x3")
                    Text("Loyalty")
            }
            
            InfomationView()
                .tabItem {
                    Image(systemName: "exclamationmark.circle")
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
                    Text("About")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
