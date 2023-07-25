//
//  Agencies.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/25/23.
//

import Foundation

// Container for multiple agencies. Used in parameterized queries
struct Agencies: Codable {
    let agencies: [Agency]
}
