//
//  OrderView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import MessageUI
import SwiftUI

struct OrderView: View {
    @ObservedObject var order = Order()
    @ObservedObject var email = EmailComposer()
    
    @State var showningEmail = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Select your Hot Drink", selection: $order.drink) {
                            ForEach(0..<Order.drinks.count, id: \.self) {
                                Text(Order.drinks[$0])
                            }
                        }
                    }
                    
                    Section {
                        Toggle(isOn: $order.specailRequestEnabled.animation()) {
                            Text("Special Requests")
                        }
                        
                        if order.specailRequestEnabled {
                            if order.drink == 6 {
                                Picker("Type of Tea", selection: $order.tea) {
                                    ForEach(0..<Order.teas.count, id: \.self) {
                                        Text(Order.teas[$0])
                                    }
                                }
                            } else {
                                Picker("Syrup", selection: $order.syrup) {
                                    ForEach(0..<Order.syrups.count, id: \.self) {
                                        Text(Order.syrups[$0])
                                    }
                                }
                                
                                Picker("Milk Types", selection: $order.milk) {
                                    ForEach(0..<Order.milkTypes.count, id: \.self) {
                                        Text(Order.milkTypes[$0])
                                    }
                                }
                                
                                Toggle(isOn: $order.chocolateSpinkles) {
                                    Text("Chocolate Spinkles")
                                }
                            }
                        }
                    }
                    
                    Section {
                        Toggle(isOn: $order.extraHot) {
                            Text("Extra Hot")
                        }
                    }
                    
                    Section {
                        
                        Stepper(value: $order.quanity, in: 1...10) {
                            Text("Number of drinks: \(order.quanity)")
                        }
                        
                        Button("Confirm Order") {
                            self.showningEmail = true
                        }
                    }
                }
                Text("Note: check email order is correct and click send")
                .font(.footnote)
                .foregroundColor(.secondary)
            }
            .navigationBarTitle("Pre-order Your Hot Drinks", displayMode: .inline)
            .sheet(isPresented: $showningEmail) {
                Text("Sent")
            }

        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
