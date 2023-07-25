//
//  FilteredPersons.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/9/23.
//

import Foundation

private func createValidMapPoints(peopleArray: Peoples) -> [Person] {
    let filteredPersons: [Person] = peopleArray.people.compactMap { person in
        guard person.latitude != nil, person.longitude != nil else {
            return nil
        }
        return person
    }
    return filteredPersons
}

func getCurrentYear() -> Int {
    let date = Date.now
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    let currentYear = Int(dateFormatter.string(from: date)) ?? 2023
    
    return currentYear
}
