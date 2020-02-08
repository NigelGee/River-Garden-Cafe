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
    @Published var showningWrongStamp = false
    @Published var showningNoReader = NFCNDEFReaderSession.readingAvailable
    
    var adjustedStamp: Int {
        numberOfStamps % 7
    }
    
    private var isRedeemed = false
    
    private let addStampTag = "\u{2}enaddStampRGC"
    private let redeemCoffeTag = "\u{2}enredeemDrinkRGC"
    
    func addStamp(redeem: Bool) {
        guard NFCNDEFReaderSession.readingAvailable else {
            showningNoReader = true
            print("Scanning Not Supported")
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        if redeem {
            isRedeemed = true
            session?.alertMessage = "Hold your iPhone near the Stamp to receive free coffee"
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
            print("Stamp")
        } else if readerString == redeemCoffeTag && isRedeemed {
            numberOfStamps -= 7
            UserDefaults.standard.set(self.numberOfStamps, forKey: "NumberOfStamps")
            print("Coffee")
        } else {
            showningWrongStamp = true
            print("Fail")
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("Active")
    }
}
