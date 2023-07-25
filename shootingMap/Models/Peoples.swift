//
//  People.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/9/23.
//
// Array struct to contain Person objects

import Foundation

// Container for multiple Person objects. Used for parameterized/unparameterized queries to DB
struct Peoples: Codable {
    let people: [Person]
}
