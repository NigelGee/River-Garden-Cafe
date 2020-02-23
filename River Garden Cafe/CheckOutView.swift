//
//  CheckOutView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 09/02/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import MessageUI
import SwiftUI
import UserNotifications

struct CheckOutView: View {
    @EnvironmentObject var tray: Tray
    
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    @State private var isDisable = false
    @State private var sentMail = false
    @State private var mailStatus: MFMailComposeResult? = nil
    @State private var message = ""
    @State private var showningAlert = false
    @State private var value: CGFloat = 0
    
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
        components.hour = 22
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        if mailStatus != nil {
            DispatchQueue.main.async {
                switch self.mailStatus {
                case .sent:
                    self.tray.orderedDrinks.removeAll()
                    self.addNotification(for: self.tray)
                case .cancelled:
                    self.showningAlert.toggle()
                    self.message = "Please confirm your order"
                case .saved:
                    self.showningAlert.toggle()
                    self.message = "Please check your draft inbox"
                case .failed:
                    self.showningAlert.toggle()
                    self.message = "Ops. Something went wrong. Please try again"
                default:
                    self.showningAlert.toggle()
                    self.message = "Ops. Something went wrong. Please try again"
                }
                self.mailStatus = nil
            }
        }
        
        return VStack {
            if tray.orderedDrinks.isEmpty {
                Text("No Orders")
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
                    .animation(.easeIn)
                }
                
                Form {
                    
                    
                    Section {
                        if maxTime < minTime {
                            Text("Pre-order unavailable, Please try tommorrow")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        } else {
                            DatePicker("Select Time", selection: $tray.time, in: minTime...maxTime ,displayedComponents: .hourAndMinute)
                            
                        }
                    }
                    
                    Section {
                        TextField("Enter Name", text: $tray.name)
                        
                    }
                    
                    Section {
                        Toggle(isOn: $tray.takeaway) {
                            Text("Take-a-Way")
                        }
                        
                        if MFMailComposeViewController.canSendMail() {
                            Button(action: {
                                self.isShowingMailView = true
                            }) {
                                Text("Confirm Order")
                            }
                            .disabled(isDisable)
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result, mailStatus: self.$mailStatus).environmentObject(self.tray)
                            }
                        } else {
                            Text("Device not congfigure to send Email for confirmation")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Ordered Drink\(tray.orderedDrinks.count > 1 ? "s" : "")", displayMode: .inline)
        .alert(isPresented: $showningAlert) {
            Alert(title: Text("Order not sent!"), message: Text(message), dismissButton: .default(Text("OK")))
        }
        .disabled(tray.orderedDrinks.isEmpty)
        .offset(y: -self.value)
        .animation(.spring())
        .onAppear(perform: checkDate)
    }
    
    private func checkDate() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { key in
            let value = key.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            self.value = value.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { key in
            self.value = 0
        }
        
        tray.time = Calendar.current.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
        
        if minTime < maxTime {
            isDisable = false
        } else {
            isDisable = true
        }
    }
    
    private func addNotification(for order: Tray) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Your order is nearly ready"
            content.body = "Please collect it in 5 mins"
            content.sound = UNNotificationSound.default
            
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
    
    private func removeOrderedDrinks(at offsets: IndexSet) {
        tray.orderedDrinks.remove(atOffsets: offsets)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView().environmentObject(Tray())
    }
}
