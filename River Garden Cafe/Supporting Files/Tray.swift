//
//  Tray.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 08/02/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import Foundation

class Tray: ObservableObject {
    var id = UUID().uuidString
    @Published var orderedDrinks = [OrderTray]()
    @Published var time = Calendar.current.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
    @Published var takeaway = false
    @Published var name = ""
}

struct OrderTray: Identifiable {
    var id = UUID()
    
    let drink: String
   
    let isTea: Bool
    let specialRequest: Bool

    let noTeaCondiment: Bool
    let teaCondiment: String
    
    let noSyrup: Bool
    let syrup: String
    let noSprinkles: Bool
    let sprinkles: String
    
    let milk: String
    let extraHot: Bool
    let sugar: String
}
