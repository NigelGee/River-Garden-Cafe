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
    
    @State private var showConfrim = false
    
    var body: some View {
        VStack {
            if tray.orderedDrinks.isEmpty {
                Text("No Drinks Ordered")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(tray.orderedDrinks) { orderDrink in
                        VStack(alignment: .leading) {
                            
                            Text(orderDrink.drink)
                                .font(.headline)
                            
                            Group {
                                if orderDrink.specialRequest {
                                    if orderDrink.isTea {
                                        if !orderDrink.noTeaCondiment {
                                            Text(orderDrink.teaCondiment)
                                        }
                                    } else {
                                        if !orderDrink.noSyrup {
                                            Text(orderDrink.syrup)
                                        }
                                        if !orderDrink.noSprinkles {
                                            Text(orderDrink.sprinkles)
                                        }
                                    }
                                    Text(orderDrink.milk)
                                }
                                
                                if orderDrink.extraHot {
                                    Text("Extra hot")
                                }
                                Text(orderDrink.sugar)
                            }
                            .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeOrderedDrinks)
                }
            }
        }
        .navigationBarTitle("Ordered Drink\(tray.orderedDrinks.count > 1 ? "s" : "")", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.showConfrim.toggle()
            }) {
                Text("Confirm")
        })
        .disabled(tray.orderedDrinks.isEmpty)
            .sheet(isPresented: $showConfrim) {
                ConfrimOrderView()
        }
    }
    
    func removeOrderedDrinks(at offsets: IndexSet) {
        tray.orderedDrinks.remove(atOffsets: offsets)
    }
}

struct CheckOutHeader: View {
    
    var body: some View {
        Text("Hello World!")
    }
    
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView().environmentObject(Tray())
    }
}
