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
    let emailComposer = EmailComposerView()
    
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
                        
                        if Order.drinks[order.drink].hasPrefix("Tea") {
                            Picker("Type of Tea", selection: $order.tea) {
                                ForEach(0..<Order.teas.count, id: \.self) {
                                    Text(Order.teas[$0])
                                }
                            }
                        }
                                                
                        if order.specailRequestEnabled {
                            Picker("Milk Types", selection: $order.milk) {
                                ForEach(0..<Order.milkTypes.count, id: \.self) {
                                    Text(Order.milkTypes[$0])
                                }
                            }
                            
                            if Order.drinks[order.drink].hasPrefix("Tea") {
                                Toggle(isOn: $order.honey) {
                                    Text("Honey")
                                }
                                
                                Toggle(isOn: $order.lemon) {
                                    Text("Lemon")
                                }
                            } else {
                                Picker("Syrup", selection: $order.syrup) {
                                    ForEach(0..<Order.syrups.count, id: \.self) {
                                        Text(Order.syrups[$0])
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
                        Text("Time")
                    }
                    
                    Section {
                        
                        Stepper(value: $order.quanity, in: 1...10) {
                            Text("Number of drinks: \(order.quanity)")
                        }
                        
                        Toggle(isOn: $order.takeAway) {
                            Text("Take-a-way")
                        }
                        
                        if MFMailComposeViewController.canSendMail() {
                            Button("Confirm Order") {
                                self.saveUserDefaults()
                                self.emailComposer.sendEmail()
                            }
                        } else {
                            Text("Device not congfigure to send Email for confirmation")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Text("Note: check email order is correct and click send")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .navigationBarTitle("Pre-order Your Hot Drinks", displayMode: .inline)
        }
    }
    
    func saveUserDefaults() {
        let userDefault = UserDefaults.standard
        userDefault.set(self.order.drink, forKey: "Drink")
        userDefault.set(self.order.specailRequestEnabled, forKey: "SpecailRequest")
        userDefault.set(self.order.syrup, forKey: "Syrup")
        userDefault.set(self.order.milk, forKey: "Milk")
        userDefault.set(self.order.tea, forKey: "Tea")
        userDefault.set(self.order.honey, forKey: "Honey")
        userDefault.set(self.order.lemon, forKey: "Lemon")
        userDefault.set(self.order.chocolateSpinkles, forKey: "Spinkles")
        userDefault.set(self.order.extraHot, forKey: "ExtraHot")
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
