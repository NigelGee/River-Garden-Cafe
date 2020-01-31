//
//  EmailComposerView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 29/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import MessageUI
import SwiftUI

class EmailComposerView: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["nigel.gee@icloud.com"])
        mail.setSubject("Subject")
        mail.setMessageBody("Body", isHTML: false)
        
        present(mail, animated: true)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
