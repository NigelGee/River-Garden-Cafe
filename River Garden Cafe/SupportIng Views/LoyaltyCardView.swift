//
//  LoyaltyCardView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct LoyaltyCardView: View {
    @ObservedObject var reader: Reader
    
    var body: some View {
        NavigationView {
            VStack {
                Text("HAVE YOUR 8th HOT DRINK ON US!")
                    .font(.caption)
                    .padding(.top)
               
                VStack{
                    ForEach(1..<5, id: \.self) { row in
                        VStack {
                            Spacer()
                            HStack {
                                ForEach(0..<2, id: \.self) { col in
                                    HStack{
                                        Spacer()
                                        ZStack {
                                            Capsule()
                                                .foregroundColor(.clear)
                                                .frame(width: 70, height: 70)
                                                .overlay(Capsule().stroke(Color.secondary, lineWidth: 2))
                                            if (col * 4) + row <= self.reader.adjustedStamp {
                                                StampView()
                                                    .accessibility(label: Text( "\(self.reader.adjustedStamp) Stamp\(self.reader.adjustedStamp < 2 ? "" : "s")"))
                                            }
                                            
                                            if (col * 4) + row == 8 {
                                                ZStack {
                                                    StampView()
                                                    Text("FREE")
                                                        .fontWeight(.heavy)
                                                        .foregroundColor(.primary)
                                                }
                                                .accessibilityElement(children: .ignore)
                                            }
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
               
                
                Spacer()
                
                if reader.numberOfStamps >= 7 {
                    Button("\(reader.numberOfStamps / 7) Free Coffee\(reader.numberOfStamps / 7 < 2 ? "" : "s")") {
                        self.reader.addStamp(reedeem: true)
                    }
                    .buttonStyle(colour: .red)
                }
                
                Button("Add Stamp") {
                    self.reader.addStamp(reedeem: false)
                }
                .buttonStyle(colour: .green)
                .padding(.bottom)
            }
            .navigationBarTitle("Loyaty Card", displayMode: .inline)
        }
        .alert(isPresented: $reader.showningWrongStamp) {
            Alert(title: Text("Wrong Stamp"), message: Text("Please use correct stamp"), dismissButton: .default(Text("OK")))
        }
// TODO:- Work out how to get the 2nd Error Alert here
//        .alert(isPresented: $reader.showningNoReader) {
//            Alert(title: Text("Scanning Not Supported"), message: Text("Please use another device that supports NFC"), dismissButton: .default(Text("OK")))
//        }
    }
}

struct LoyaltyCardView_Previews: PreviewProvider {
    static var previews: some View {
        LoyaltyCardView(reader: Reader())
    }
}
