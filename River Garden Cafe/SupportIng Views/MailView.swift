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
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    var mailSubject: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        let number = "\(Order.quanityString[order.quanity - 1]) "
        let size = "\(Order.sizes[order.size]) "
        var drink = ""
        if Order.drinks[order.drink].hasPrefix("Tea") {
            drink = "\(Order.teas[order.tea]) \(Order.drinks[order.drink]) "
        } else {
            drink = "\(Order.drinks[order.drink]) "
        }
        let time = "@ \(formatter.string(from: order.time))"
        
        let subject = number + size + drink + time
        
        return subject
    }
    
    var mailBody: String {
        var special = ""
        
        if order.specialRequestEnabled {
            let milk = "\(Order.milkTypes[order.milk].hasPrefix("None") ? "No" : Order.milkTypes[order.milk]) Milk\n"
            var extra = ""
            var syrup = ""
            if Order.drinks[order.drink].hasPrefix("Tea") {
                extra = "\(Order.teaCondiments[order.teaCondiment].hasPrefix("None") ? "" : "with \(Order.teaCondiments[order.teaCondiment])\n")"
            } else {
                syrup = "\(Order.syrups[order.syrup].hasPrefix("None") ? "" : "with \(Order.syrups[order.syrup]) Syrup\n")"
                extra = "\(Order.spinkles[order.spinkle].hasPrefix("None") ? "" : "with\(Order.spinkles[order.spinkle]) Spinkles\n")"
            }
            special = milk + syrup + extra
        }
        
        let sugar = "\(order.sugar == 0 ? "No Sugar" : "\(order.sugar) teaspoon\(order.sugar == 1 ? "" : "s") of sugar")\n"
        let hot = "\(order.extraHot ? "Extra Hot\n" : "")"
        let takeaway = "\(order.takeAway ? "Take-A-Way\n" : "Drink In\n")"
        let info = "Pay in store\nType any additional information below"
        let body = special + sugar + hot + takeaway + info
        
        return body
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation, result: $result)
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
