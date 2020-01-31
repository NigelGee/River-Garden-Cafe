//
//  PrivacyView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 30/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Near Field Comuication (NFC):-\nThis app does not collect any data device. Only use NFC to vefify that a correct 'Stamp' has been used")
                Text("Email Address:-\nAddresses are only used to indentify user for their order. No addresses are stored or passes on to third parties")
            }
            .navigationBarTitle("Privacy", displayMode: .inline)
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
