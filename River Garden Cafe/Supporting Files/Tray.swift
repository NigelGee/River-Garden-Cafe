//
//  Tray.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 08/02/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import Foundation

class Tray: ObservableObject {
    @Published var orderedDrinks = [Order]()
}
