//
//  FilterViewModel.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/26/23.
//

import Foundation

class FilterViewModel: ObservableObject {
    @Published var flee: String
    @Published var armed: String
    @Published var city: String
    @Published var state: String
    @Published var race: String
    @Published var gender: String
    @Published var dateRangeLeading: Int
    @Published var dateRangeTrailing: Int
    
    init(flee: String, armed: String, city: String, state: String, race: String, gender: String, dateRangeLeading: Int, dateRangeTrailing: Int) {
        self.flee = flee
        self.armed = armed
        self.city = city
        self.state = state
        self.race = race
        self.gender = gender
        self.dateRangeLeading = dateRangeLeading
        self.dateRangeTrailing = dateRangeTrailing
    }
}
