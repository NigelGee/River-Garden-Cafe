//
//  TermsView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 29/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        NavigationView {
            List {
                Text("No Cash Value")
                Text("Offer subject to availabilty")
                Text("Loyaty Card Scheme:-\nThe venue holds the right to withdraw the scheme at anytime")
            }
            .navigationBarTitle("Terms & Conditions", displayMode: .inline)
        }
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
