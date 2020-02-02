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
    static let milkTypes = ["Semi-Skimmed", "Skimmed", "Oatmeal", "No Milk"]
    static let teas = ["Indian", "English Breakfast", "Earl Grey", "Green Tea"]
    static let quanityString = ["One", "Two", "Three", "Four", "Five"]
    
    @Published var drink = UserDefaults.standard.integer(forKey: "Drink")
    @Published var quanity = 1
    @Published var time = Calendar.current.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
    
    @Published var specailRequestEnabled = UserDefaults.standard.bool(forKey: "SpecailRequest") {
        didSet {
            if specailRequestEnabled == false {
                syrup = 0
                milk = 0
                chocolateSpinkles = false
                tea = 0
            }
        }
    }
    @Published var syrup = UserDefaults.standard.integer(forKey: "Syrup")
    @Published var milk = UserDefaults.standard.integer(forKey: "Milk")
    @Published var chocolateSpinkles = UserDefaults.standard.bool(forKey: "Spinkles")
    @Published var tea = UserDefaults.standard.integer(forKey: "Tea")
    @Published var honey = UserDefaults.standard.bool(forKey: "Honey")
    @Published var lemon = UserDefaults.standard.bool(forKey: "Lemon")
    
    @Published var extraHot = UserDefaults.standard.bool(forKey: "ExtraHot")
    @Published var takeAway = false
}
