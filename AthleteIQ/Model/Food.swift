//
//  Food.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//

import Foundation
import SwiftData

@Model
class Food {
    var name: String
//    var category: String
    var date: Date
    var carbs: Int
    var fat: Int
    var protein: Int
    
    
    init(name: String, date: Date, carbs: Int, fat: Int, protein: Int) {
        self.name = name
        self.date = date
        self.carbs = carbs
        self.fat = fat
        self.protein = protein
    }
    
}
