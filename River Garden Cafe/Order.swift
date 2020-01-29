//
//  Order.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 28/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import Foundation

class Order: ObservableObject {
    
    static let drinks = ["Latte", "Flat White", "Americano","Cappacino","Mocha","Hot Chocalate", "Tea"]
    static let syrups = ["None", "Vanilla", "Caramal", "Hazelnut"]
    static let milkTypes = ["Semi-Skimmed", "Skimmed", "Oatmeal"]
    static let teas = ["Indian", "English Breakfast", "Earl Grey", "Green Tea"]
    
    @Published var drink = 0
    @Published var quanity = 1
    
    @Published var specailRequestEnabled = false {
        didSet {
            if specailRequestEnabled == false {
                syrup = 0
                milk = 0
                chocolateSpinkles = false
                tea = 0
            }
        }
    }
    @Published var syrup = 0
    @Published var milk = 0
    @Published var chocolateSpinkles = false
    @Published var tea = 0
    
    @Published var extraHot = false
}
