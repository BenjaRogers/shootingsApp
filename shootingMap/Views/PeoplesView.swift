//
//  LocationsView.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/9/23.
//

import SwiftUI
import MapKit

struct PeoplesView: View {
    @EnvironmentObject private var vm: PeoplesViewModel
    @EnvironmentObject private var fvm: FilterViewModel
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
//    @State var flee: String = ""
//    @State var armed: String = ""
//    @State var city: String = ""
//    @State var state: String = ""
//    @State var race: String = ""
//    @State var gender: String = ""
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion,
                annotationItems: vm.validMapPoints,
                annotationContent: {person in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: person.latitude!, longitude: person.longitude!)) {
                    PersonMapAnnotationView().onTapGesture {
                        vm.showNextPerson(person: person)
                    }
                }
            }).ignoresSafeArea()
            
            // Summary view @ bottom of view
            VStack(spacing: 0) {
                headerStack
                .padding()
                Spacer()
                ZStack {
                    ForEach(vm.validMapPoints) { person in
                        if vm.mapLocation == person {
                            PersonPreviewView(person: person)
                        }
                    }
                }
            }
            .sheet(item: $vm.personDetails, onDismiss: nil) { person in
                DetailView(person:person)
            }
        }
    }
}

struct PeoplesView_Previews: PreviewProvider {
    static var previews: some View {
        let peopleArray = shootAPI().fetchAPIParamPerson(flee: "fleeing", armed: "unarmed", city: "", state: "", race: "", gender: "F", dateRangeLeading: 2023, dateRangeTrailing: 2023)!
        PeoplesView().environmentObject(PeoplesViewModel(peopleArray: peopleArray))
    }
}

extension PeoplesView {
    private var headerStack: some View {
        VStack {
            Button(action: vm.toggleFiltersForm) {
                Text("Filters")
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                    }
            }
            if vm.showFiltersForm {
                FilterView()
            }
        }
        .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color:Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
    
}
