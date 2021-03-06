//
//  LoyaltyCardView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import SwiftUI

struct LoyaltyCardView: View {
    @ObservedObject var reader = Reader()
    let numberStamp = 8
    
    var body: some View {
        NavigationView {
            VStack {
                Text("HAVE YOUR \(numberStamp)th HOT DRINK ON US!")
                    .font(.caption)
                    .padding(.top)
                    .accessibility(label: Text("have your \(numberStamp)th hot drink on us"))
                
                VStack{
                    ForEach(1..<(numberStamp / 2) + 1, id: \.self) { row in
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
                                            if (col * self.numberStamp / 2) + row <= self.reader.adjustedStamp {
                                                StampView()
                                            }
                                            
                                            if (col * self.numberStamp / 2) + row == self.numberStamp {
                                                ZStack {
                                                    StampView()
                                                    Text("FREE")
                                                        .fontWeight(.heavy)
                                                        .font(.system(size: 18))
                                                        .foregroundColor(.black)
                                                }
                                                
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
                .accessibilityElement(children: .ignore)
                .accessibility(label: Text( "\(self.reader.adjustedStamp) Stamp\(self.reader.adjustedStamp < 2 ? "" : "s")"))
                
                Spacer()
                
                if reader.numberOfStamps >= 7 {
                    Button("\(reader.numberOfStamps / 7) Free Coffee\(reader.numberOfStamps / 7 < 2 ? "" : "s")") {
                        self.reader.addStamp(redeem: true)
                    }
                    .buttonStyle(colour: .red)
                }
                
                Button("Add Stamp") {
                    self.reader.addStamp(redeem: false)
                }
                .buttonStyle(colour: .blue)
                .padding(.bottom)
                
            }
            .navigationBarTitle("Loyalty Card", displayMode: .inline)
        }
        .alert(isPresented: $reader.showningWrongStamp) {
            Alert(title: Text("Wrong Stamp"), message: Text("Please try again!"), dismissButton: .default(Text("OK")))
        }
        //     TODO:- get 2nd Alert to show
        //                Alert(title: Text("Scanning Not Supported"), message: Text("Please use another device that supports NFC"), dismissButton: .default(Text("OK")))
    }
}

struct LoyaltyCardView_Previews: PreviewProvider {
    static var previews: some View {
        LoyaltyCardView()
    }
}
