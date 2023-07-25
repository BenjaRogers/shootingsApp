//
//  person.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/8/23.
//

import Foundation
import MapKit

struct Person: Codable, Identifiable, Equatable {
    let db_id: Int
    let id: String
    var name: String? = "NA"
    var date: String? = "NA"
    var body_camera: Bool?
    var city: String? = "NA"
    var county: String? = "NA"
    var state: String? = "NA"
    let longitude: Double?
    let latitude: Double?
    var location_precision: String? = "NA"
    let age: Int?
    var gender: String? = "NA"
    var race: String? = "NA"
    var race_source: String? = "NA"
    let was_mental_illness_related: Bool?
    var threat_type: String? = "NA"
    var armed_with: String? = "NA"
    var flee_status: String? = "NA"
    var agency_ids: String? = "NA"
}
