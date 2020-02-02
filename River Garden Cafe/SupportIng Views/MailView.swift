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

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    @ObservedObject var order = Order()
    
    let info = "Type any additional information below"

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
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
        let vc = MFMailComposeViewController()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        vc.setToRecipients(["nigel.gee@icloud.com"])
        vc.setSubject("Order for \(Order.quanityString[order.quanity - 1]) \(Order.drinks[order.drink].hasPrefix("Tea") ? "\(Order.teas[order.tea]) \(Order.drinks[order.drink])" : Order.drinks[order.drink]) @ \(formatter.string(from: order.time))")
        if order.specailRequestEnabled {
            if Order.drinks[order.drink].hasPrefix("Tea") {
                vc.setMessageBody("Milk Type: \(Order.milkTypes[order.milk])\nHoney: \(order.honey ? "Yes" : "No")\nLemon: \(order.lemon ? "Yes" : "No")\nExtra Hot \(order.extraHot ? "Yes" : "No")\n\(order.takeAway ? "Take-A-Way" : "Drink In")\n\(info)", isHTML: false)
            } else {
                vc.setMessageBody("Milk Type: \(Order.milkTypes[order.milk])\nSyrup: \(Order.syrups[order.syrup])\nChocolate Spinkles: \(order.chocolateSpinkles ? "Yes" : "No")\nExtra Hot: \(order.extraHot ? "Yes" : "No")\n\(order.takeAway ? "Take-A-Way" : "Drink In")\n\(info)", isHTML: false)
            }
        } else {
            vc.setMessageBody("Extra Hot: \(order.extraHot ? "Yes" : "No")\n\(order.takeAway ? "Take-A-Way" : "Drink In")\n\(info)", isHTML: false)
        }
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {

    }
}
