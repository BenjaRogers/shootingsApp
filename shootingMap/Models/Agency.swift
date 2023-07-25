//
//  Agency.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/25/23.
//

import Foundation

// Default values for fields that might be blank so unpacking isn't a mess later...
// Probably a better way to do this?
struct Agency: Codable, Identifiable, Equatable {
    let db_id: Int
    let id: String
    var name: String? = "NA"
    var type: String? = "NA"
    var state: String? = "NA"
    var oricodes: String? = "NA"
    var total_shootings: Int
}
