//
//  OrderView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var order = Order()
    @ObservedObject var tray = Tray()
    
    @State private var showningAddedView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    drinkTypeSection
                    specialRequestSection
                    takeOrderSection
                }
                .navigationBarTitle("Pre-order", displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: CheckOutView().environmentObject(tray)) {
                        VStack {
                            if tray.orderedDrinks.isEmpty {
                                Image(systemName: "tray")
                                    .foregroundColor(.secondary)
                            } else {
                                Image(systemName: "tray.and.arrow.down.fill")
                            }
                            Text("Tray")
                                .font(.caption)
                                .foregroundColor(tray.orderedDrinks.isEmpty ? .secondary : .blue)
                        }
                    }
                )
            }
            .blur(radius: showningAddedView ? 3 : 0)
            
            if showningAddedView {
                AddedNotificationView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.showningAddedView.toggle()
                        }
                    }
            }
        }
    }
    
    private var drinkTypeSection: some View {
        Section {
            Picker("Size of drink", selection: $order.size) {
                ForEach(0..<Order.sizes.count, id: \.self) {
                    Text(Order.sizes[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Select your Hot Drink", selection: $order.drink) {
                ForEach(0..<Order.drinks.count, id: \.self) {
                    Text(Order.drinks[$0])
                }
            }
        }
    }
    
    private var specialRequestSection: some View {
        Section {
            Toggle(isOn: $order.specialRequestEnabled.animation()) {
                Text("Special Requests")
            }
            
            if Order.drinks[order.drink].hasPrefix("Tea") {
                Picker("Type of Tea", selection: $order.tea) {
                    ForEach(0..<Order.teas.count, id: \.self) {
                        Text(Order.teas[$0])
                    }
                }
            }
            
            if order.specialRequestEnabled {
                Picker("Milk Types", selection: $order.milk) {
                    ForEach(0..<Order.milkTypes.count, id: \.self) {
                        Text(Order.milkTypes[$0])
                    }
                }
                
                if Order.drinks[order.drink].hasPrefix("Tea") {
                    Picker("Condiments", selection: $order.teaCondiment) {
                        ForEach(0..<Order.teaCondiments.count, id: \.self) {
                            Text(Order.teaCondiments[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } else {
                    Picker("Syrup", selection: $order.syrup) {
                        ForEach(0..<Order.syrups.count, id: \.self) {
                            Text(Order.syrups[$0])
                        }
                    }
                    
                    Picker("Spinkles", selection: $order.spinkle) {
                        ForEach(0..<Order.spinkles.count, id: \.self) {
                            Text(Order.spinkles[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Stepper(value: $order.sugar, in: 0...6) {
                Text("\(order.sugar == 0 ? "No Sugar" : "\(order.sugar) teaspoon\(order.sugar == 1 ? "" : "s") of sugar")")
            }
            
            Toggle(isOn: $order.extraHot) {
                Text("Extra Hot")
            }
        }
    }
    
    private var takeOrderSection: some View {
        Section {
            Stepper(value: $order.quanity, in: 1...5) {
                Text("Number of drinks: \(order.quanity)")
            }
            
            Button(action: {
                self.appendOrderedDrink()
                self.showningAddedView.toggle()
                self.saveUserDefaults()
            }) {
                Text("Add to Tray")
            }
        }
    }
    
    private func appendOrderedDrink() {
        let isTea = Order.drinks[self.order.drink].hasPrefix("Tea")
        let drink = "\(Order.quanityString[self.order.quanity - 1]) \(Order.sizes[self.order.size]) \(isTea ? "\(Order.teas[order.tea]) " : "")\(Order.drinks[order.drink])"
        
        let noTeaCondiment = Order.teaCondiments[order.teaCondiment].hasPrefix("None")
        let teaCondiment = "with \(Order.teaCondiments[order.teaCondiment])"
        
        let noSyrup = Order.syrups[order.syrup].hasPrefix("None")
        let syrup = "with \(Order.syrups[order.syrup]) syrup"
        let noSprinkles = Order.spinkles[order.spinkle].hasPrefix("None")
        let sprinkles = "\(noSyrup ? "with" : "and") \(Order.spinkles[order.spinkle]) sprinkles"
        
        
        let milk = "\(Order.milkTypes[self.order.milk].hasPrefix("None") ? "No" : Order.milkTypes[self.order.milk]) Milk"
        let sugar = "\(order.sugar == 0 ? "No Sugar" : "\(order.sugar) teaspoon\(order.sugar == 1 ? "" : "s") of sugar")"
        
        let drinkItem = OrderTray(drink: drink, isTea: isTea, specialRequest: self.order.specialRequestEnabled, noTeaCondiment: noTeaCondiment, teaCondiment: teaCondiment, noSyrup: noSyrup, syrup: syrup, noSprinkles: noSprinkles, sprinkles: sprinkles, milk: milk, extraHot: self.order.extraHot, sugar: sugar)
        self.tray.orderedDrinks.append(drinkItem)
    }
    
    private func saveUserDefaults() {
        let userDefault = UserDefaults.standard
        userDefault.set(self.order.size, forKey: "Size")
        userDefault.set(self.order.drink, forKey: "Drink")
        userDefault.set(self.order.specialRequestEnabled, forKey: "SpecialRequest")
        userDefault.set(self.order.syrup, forKey: "Syrup")
        userDefault.set(self.order.spinkle, forKey: "Spinkle")
        userDefault.set(self.order.milk, forKey: "Milk")
        userDefault.set(self.order.tea, forKey: "Tea")
        userDefault.set(self.order.teaCondiment, forKey: "Condiment")
        userDefault.set(self.order.extraHot, forKey: "ExtraHot")
        userDefault.set(self.order.sugar, forKey: "Sugar")
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().environmentObject(Order())
    }
}
