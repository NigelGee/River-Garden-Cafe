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
                Text("There are no membership fees associated with Loyaty Card Scheme. Stamps accumulated under the programme have no cash value")
                Text("Your Stamps under the Loyalty Card Scheme are personal to you and may not be sold, transferred or assigned to, or shared with, family, friends or other")
                Text("The venue reserves the right to terminate, discontinue, cancel or amend the Loyalty Card Scheme at any time and in its sole discretion without notice to you.")
                Text("The above terms are governed by the laws of England and Wales")
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
