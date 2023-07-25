//
//  DetailView.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/20/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var vm: PeoplesViewModel
    let person: Person
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                backButton
                personDetails
                Divider()
                incidentDetails

            }
        }
        .background(.ultraThinMaterial)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let person = shootAPI().fetchAPISinglePerson(id: 3)!
//        DetailView(person: person)
//
//
//    }
//}

extension DetailView {
    private var personDetails: some View {
        Section {
            VStack(alignment:.leading, spacing: 8) {
                HStack() {
                    Text("Date: ").font(.title2).fontWeight(.semibold)
                    Text(person.date ?? "NA").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                }
                HStack {
                    Text("Age: ").font(.title2).fontWeight(.semibold)
                    Text("\(person.age ?? 0)").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                }
                HStack {
                    Text("Race: ").font(.title2).fontWeight(.semibold)
                    Text("\(person.race ?? "NA") (\(person.race_source ?? "NA"))").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                }
                HStack {
                    Text("Location: ").font(.title2).fontWeight(.semibold)
                    Text("\(person.city ?? "NA"), \(person.state ?? "NA")").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                }
                HStack {
                    Text("County: ").font(.title2).fontWeight(.semibold)
                    Text(person.county ?? "NA").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                }
            }.padding()
        }
    }
    private var incidentDetails: some View {
        Section {
            VStack(alignment:.leading, spacing: 8) {
                HStack {
                    Text("Threat Type: ").font(.title2).fontWeight(.semibold)
                    Text(person.threat_type ?? "NA").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                }
                HStack {
                    Text("Armed: ").font(.title2).fontWeight(.semibold)
                    Text(person.armed_with ?? "NA").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                }
                HStack {
                    Text("Flee: ").font(.title2).fontWeight(.semibold)
                    if person.flee_status ?? "NA" == "foot" {
                        Text("On foot").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    }
                    if person.flee_status ?? "NA" == "car" {
                        Text("Via Car").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    }
                    if person.flee_status ?? "NA" == "other" {
                        Text("Via another vehicle").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    }
                    if person.flee_status ?? "NA" == "not" {
                        Text("Not Fleeing").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    } else {
                        Text("NA").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    }
                }
                HStack {
                    Text("Body Camera").font(.title2).fontWeight(.semibold)
                    if (person.body_camera != nil) {
                        if person.body_camera! {
                            Text("Yes").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                        } else {
                            Text("No").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                        }
                    } else {
                        Text("NA").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    }
                }
                HStack {
                    Text("Mental Illness Related: ").font(.title2).fontWeight(.semibold)
                    if (person.was_mental_illness_related!) {
                        Text("Yes").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    } else {
                        Text("No").font(.title3).fontWeight(.semibold).foregroundColor(.secondary)
                    }
                }
            }
        }.padding()
    }
    private var backButton: some View {
        Button {
            vm.personDetails = nil
        } label: {
        Image(systemName: "arrowshape.backward")
        }
        .font(.headline)
        .padding(16)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(radius: 4)
        .padding()
        
    }
}
