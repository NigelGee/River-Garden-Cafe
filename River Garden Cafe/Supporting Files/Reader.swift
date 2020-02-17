//
//  Reader.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import CoreNFC
import UIKit

class Reader: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    
    var session: NFCNDEFReaderSession?
    
    @Published var numberOfStamps = UserDefaults.standard.integer(forKey: "NumberOfStamps")
    @Published var showningAlert = false
    @Published var title = ""
    @Published var message = ""
    
    var adjustedStamp: Int {
        numberOfStamps % 7
    }
    
    private var isRedeemed = false
    
    private let addStampTag = "\u{2}enaddStampRGC"
    private let redeemDrinkTag = "\u{2}enredeemDrinkRGC"
    
    func addStamp(redeem: Bool) {
        guard NFCNDEFReaderSession.readingAvailable else {
            title = "Scanning Not Supported"
            message = "Please use a device that supports NFC"
            showningAlert = true
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        if redeem {
            isRedeemed = true
            session?.alertMessage = "Hold your iPhone near the Stamp to receive free hot drink"
        } else {
            isRedeemed = false
            session?.alertMessage = "Hold your iPhone near the Stamp to add a stamp"
        }
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var readerString = ""
        
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    readerString = string
                }
            }
        }
        
        if readerString == addStampTag && !isRedeemed {
            numberOfStamps += 1
            UserDefaults.standard.set(self.numberOfStamps, forKey: "NumberOfStamps")
        } else if readerString == redeemDrinkTag && isRedeemed {
            numberOfStamps -= 7
            UserDefaults.standard.set(self.numberOfStamps, forKey: "NumberOfStamps")
        } else {
            title = "Wrong Stamp"
            message = "Please try again!"
            showningAlert = true
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("Active")
    }
}
