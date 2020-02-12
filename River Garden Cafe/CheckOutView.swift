//
//  CheckOutView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 09/02/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var tray: Tray
    
    var body: some View {
        VStack {
            if tray.orderedDrinks.isEmpty {
                Text("No Drinks Ordered")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(tray.orderedDrinks) { orderDrink in
                        HStack {
                            Text("\(Order.drinks[orderDrink.drink])")
                        }
                    }
                .onDelete(perform: removeOrderedDrinks)
                }
            }
        }
        .navigationBarTitle("Ordered Drink\(tray.orderedDrinks.count > 1 ? "s" : "")", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                // send email and deleteAll()
            }) {
                Text("Confirm")
        })
        .disabled(tray.orderedDrinks.isEmpty)
    }
    
    func removeOrderedDrinks(at offsets: IndexSet) {
        tray.orderedDrinks.remove(atOffsets: offsets)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView().environmentObject(Tray())
    }
}
