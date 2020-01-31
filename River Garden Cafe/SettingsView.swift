//
//  SettingsView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink(destination: TermsView()) {
                    Text("Terms & Conditions")
                }
                
                NavigationLink(destination: PrivacyView()) {
                    Text("Privacy Policy")
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
