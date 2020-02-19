//
//  MailView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 02/02/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI
import UIKit
import MessageUI

struct MailView: UIViewControllerRepresentable {
    
    @EnvironmentObject var order: Order
    @EnvironmentObject var tray: Tray
    @Environment(\.presentationMode) var presentationMode
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    var mailSubject: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        var name = ""
        let takeaway = "\(tray.takeaway ? "Take-a-Way" : "Drink In")"
        let time = formatter.string(from: tray.time)
        if !tray.name.isEmpty {
            name = "for \(tray.name)"
        }
        let subject = "\(takeaway) order \(name) @ \(time)"
        
        return subject
    }
    
    var mailBody: String {
        var body = ""
        
        for item in tray.orderedDrinks {
            var bodyItems = ""
            var special = ""
            
            let drink = "\(item.drink)\n"
            if item.specialRequest {
                var syrup = ""
                var extra = ""
                if item.isTea {
                    extra = "\(item.noTeaCondiment ? "" : "\(item.teaCondiment)\n")"
                } else {
                    syrup = "\(item.noSyrup ? "" : "\(item.syrup)\n")"
                    extra = "\(item.noSprinkles ? "" : "\(item.sprinkles)\n")"
                }
                
                let milk = "\(item.milk)\n"
                special = milk + syrup + extra
            }
            
            let extraHot = "\(item.extraHot ? "Extra Hot\n" : "")"
            let sugar = "\(item.sugar)\n\n"
            bodyItems = drink + special + extraHot + sugar
            body += bodyItems
        }
                
        return body
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        
        init(presentationMode: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentationMode = presentationMode
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                $presentationMode.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                print(error!.localizedDescription)
                return
            }
            self.result = .success(result)

            switch result {
                case .sent:
                    print("sent")
                case .saved:
                    print("saved")
                case .failed:
                    print("failed")
                case .cancelled:
                    print("cancelled")
                default:
                    print("Unknown")
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, result: $result)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mailVC = MFMailComposeViewController()
        
        mailVC.setToRecipients(["nigel.gee@icloud.com"])
        mailVC.setSubject(mailSubject)
        mailVC.setMessageBody(mailBody, isHTML: false)
        mailVC.mailComposeDelegate = context.coordinator
        
        return mailVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
        
    }
}
