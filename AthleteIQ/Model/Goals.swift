//
//  Goals.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//
import Foundation
import SwiftData

@Model
class Goals {
    var workoutsPerWeek: Int
    var cardioPerWeek: Int
    var calorieIntake: Int
    var hoursOfSleep: Int
    
    
    init(workoutsPerWeek: Int, cardioPerWeek: Int, calorieIntake: Int, hoursOfSleep: Int) {
        self.workoutsPerWeek = workoutsPerWeek
        self.cardioPerWeek = cardioPerWeek
        self.calorieIntake = calorieIntake
        self.hoursOfSleep = hoursOfSleep
    }
    
}
