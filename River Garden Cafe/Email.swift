//
//  Email.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 28/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import MessageUI
import UIKit

class EmailComposer: NSObject, MFMailComposeViewControllerDelegate, ObservableObject {

    func configuredMailComposeViewController () -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.delegate = self as? UINavigationControllerDelegate
       
        mailComposerVC.setToRecipients(["nigel.gee@icloud.com"])
        mailComposerVC.setSubject("Order for River Gardens Cafe")
        mailComposerVC.setMessageBody("Body", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
