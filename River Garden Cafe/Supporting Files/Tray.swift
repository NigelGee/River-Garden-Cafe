//
//  Tray.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 08/02/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import Foundation

class Tray: ObservableObject {
    @Published var orderedDrinks = [OrderTray]()
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
