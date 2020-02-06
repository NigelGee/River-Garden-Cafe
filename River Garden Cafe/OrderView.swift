//
//  OrderView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import UserNotifications
import MessageUI
import SwiftUI

struct OrderView: View {
    @ObservedObject var order = Order()
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    @State private var isDisable = false
    
    var minTime: Date {
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let hour = (timeComponents.hour ?? 8)
        let minute = (timeComponents.minute ?? 0) + 10
        
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var maxTime: Date {
        var components = DateComponents()
        components.hour = 19
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
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
                    
                    Section {
                        if minTime >= maxTime {
                            Text("Pre-order unavailable, Please try tommorrow")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        } else {
                            DatePicker("Time", selection: $order.time, in: minTime...maxTime ,displayedComponents: .hourAndMinute)
                        }
                    }
                    
                    Section {
                        
                        Stepper(value: $order.quanity, in: 1...5) {
                            Text("Number of drinks: \(order.quanity)")
                        }
                        
                        
                        Toggle(isOn: $order.takeAway) {
                            Text("Take-A-Way")
                        }
                        
                        if MFMailComposeViewController.canSendMail() {
                            Button("Confirm Order") {
                                self.saveUserDefaults()
                                self.addNotification(for: self.order)
                                self.isShowingMailView = true
                            }
                            .disabled(isDisable)
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result).environmentObject(self.order)
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
        .onAppear(perform: setIsDisable)
        
    }
    
    func saveUserDefaults() {
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
    
    func setIsDisable() {
        if minTime < maxTime {
            isDisable = false
        } else {
            isDisable = true
        }
    }
    
    func addNotification(for order: Order) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Your \(Order.drinks[order.drink]) is nearly ready"
            content.subtitle = "Please collect it in 5 mins"
            
            let time = Calendar.current.date(byAdding: .minute, value: -5, to: order.time)
            let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: time ?? Date())
            let hour = (timeComponents.hour ?? 9)
            let minute = (timeComponents.minute ?? 0)
            
            var notificationComponets = DateComponents()
            notificationComponets.hour = hour
            notificationComponets.minute = minute
            
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: notificationComponets, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { setting in
            if setting.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("No Alerts")
                    }
                }
            }
        }
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().environmentObject(Order())
    }
}
