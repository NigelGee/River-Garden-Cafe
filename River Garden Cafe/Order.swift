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
    static let milkTypes = ["Semi-Skimmed", "Skimmed", "Oatmeal", "None"]
    static let teas = ["English", "Earl Grey", "Green"]
    static let sizes = ["Regular", "Medium", "Large"]
    static let spinkles = ["None", "Chocolate", "Cinnamon"]
    static let teaCondiments = ["None","Honey", "Lemon"]
    static let quanityString = ["One", "Two", "Three", "Four", "Five"]
    
    @Published var drink = UserDefaults.standard.integer(forKey: "Drink")
    @Published var quanity = 1
    @Published var time = Calendar.current.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
    
    @Published var specialRequestEnabled = UserDefaults.standard.bool(forKey: "SpecialRequest") {
        didSet {
            if specialRequestEnabled == false {
                syrup = 0
                milk = 0
                spinkle = 0
                tea = 0
                sugar = 0
            }
        }
    }
    @Published var size = UserDefaults.standard.integer(forKey: "Size")
    @Published var syrup = UserDefaults.standard.integer(forKey: "Syrup")
    @Published var milk = UserDefaults.standard.integer(forKey: "Milk")
    @Published var spinkle = UserDefaults.standard.integer(forKey: "Spinkle")
    @Published var tea = UserDefaults.standard.integer(forKey: "Tea")
    @Published var teaCondiment = UserDefaults.standard.integer(forKey: "Condiment")
    @Published var extraHot = UserDefaults.standard.bool(forKey: "ExtraHot")
    @Published var sugar = UserDefaults.standard.integer(forKey: "Sugar")
    @Published var takeAway = false
    
}
