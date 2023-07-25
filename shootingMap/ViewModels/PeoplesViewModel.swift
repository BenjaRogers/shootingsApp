//
//  PeoplesViewModel.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/9/23.
//

import Foundation
import MapKit
import SwiftUI

class PeoplesViewModel: ObservableObject {
    @Published var peopleArray: Peoples
    
    @Published var mapLocation: Person
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    @Published var validMapPoints: [Person] = [Person]()
    
    @Published var showFiltersForm: Bool = false
    
    @Published var showPersonDetails: Bool = false
    @Published var personDetails: Person? = nil
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
    
    
    init(peopleArray: Peoples) {
        self.peopleArray = peopleArray
        self.mapLocation = peopleArray.people.first!
        self.updateMapRegion(person: mapLocation)
        self.validMapPoints = createValidMapPoints()
    }
    
    // Update map region to location of first record
    private func updateMapRegion(person: Person) {
        withAnimation(.easeInOut) {
            if (person.latitude != nil) && (person.longitude != nil) {
                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude!, longitude: person.longitude!), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            }
        }
    }
    
    func showNextPerson(person: Person) {
        withAnimation(.easeInOut) {
            mapLocation = person
        }
    }
    
    // Open and close filters view
    func toggleFiltersForm() {
        withAnimation(.easeInOut) {
            showFiltersForm = !showFiltersForm
        }
    }
    
    func updatePeopleArray(flee: String, armed: String, city: String, state: String, race: String, gender: String, dateRangeLeading: Int, dateRangeTrailing: Int) -> () -> (){
        return {
            self.peopleArray = shootAPI().fetchAPIParamPerson(flee: flee, armed: armed, city: city, state: state, race: race, gender: gender, dateRangeLeading: dateRangeLeading, dateRangeTrailing: dateRangeTrailing)!
            self.validMapPoints = self.createValidMapPoints()
            self.toggleFiltersForm()
        }
    }
    
    // Get array of person objects with latitude & longitude != nil
    private func createValidMapPoints() -> [Person] {
        let filteredPersons: [Person] = self.peopleArray.people.compactMap { person in
            guard person.latitude != nil, person.longitude != nil else {
                return nil
            }
            return person
        }
        self.mapLocation = filteredPersons.first!
        self.updateMapRegion(person: mapLocation)
        return filteredPersons
    }
    
    
}
