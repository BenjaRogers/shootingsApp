//
//  Persons.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/11/23.
//

import Foundation

//Container for SINGLE person object to simplify decoding FetchApiSinglePerson. Probably don't need this since I don't think this view/endpoint will really get used. but leave it for now.
struct Persons: Codable {
    let people: Person
}
