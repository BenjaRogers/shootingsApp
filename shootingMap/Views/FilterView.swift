//
//  FilterView.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/12/23.
//

import SwiftUI


enum States: String, CaseIterable, Identifiable {
    case All, AL, AK, AZ, AR, CA, CO, CT ,DE ,DC, FL, GA, HI, ID, IL, IN, IA, KS, KY, LA, ME, MT, NE, NV, NH, NJ, NM, NY, NC, ND, OH, OK, OR, MD, MA, MI, MN, MS, MO, PA, RI, SC, SD, TN, TX, UT, VT, VA, WA ,WV , WI , WY
    
    var id: Self {self}
}

enum Races: String, CaseIterable, Identifiable {
    case any, white, black, asian, nativeAmerican, hispanic, other, unknown
    
    var id: Self {self}
}

struct FilterView: View {
//    @State var flee: String = ""
//    @State var armed: String = ""
//    @State var city: String = ""
//    @State var state: String = ""
//    @State var race: String = ""
//    @State var gender: String = ""
//    @State var dateRangeLeading: Int = 2023
//    @State var dateRangeTrailing: Int = 2023
    
    @EnvironmentObject var vm: PeoplesViewModel
    @EnvironmentObject var fvm: FilterViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Location").fontWeight(.bold)) {
                    Picker(selection: $fvm.state, label: Text("State")) {
                        ForEach(States.allCases) { stateCode in
                            Text("\(stateCode.rawValue)").tag(stateCode.rawValue)
                        }
                    }
                    TextField("City", text: $fvm.city)
                }
                
                Section(header: Text("Circumstance").fontWeight(.bold)) {
                    Picker(selection: $fvm.armed, label: Text("Armed")) {
                        Text("Any").tag("")
                        Text("Armed").tag("armed")
                        Text("Unarmed").tag("unarmed")
                    }.pickerStyle(.segmented)
                    
                    Picker(selection: $fvm.flee, label: Text("Flee").fontWeight(.bold)) {
                        Text("Any").tag("")
                        Text("Fleeing").tag("fleeing")
                        Text("Not Fleeing").tag("Not+fleeing")
                    }.pickerStyle(.segmented)
                }
                Section(header: Text("Date Range").fontWeight(.bold)) {
                    Picker("From", selection: $fvm.dateRangeLeading) {
                        ForEach(2015...getCurrentYear(), id: \.self) {
                            Text("\(String($0))").tag($0)
                        }
                    }
                    Picker("To", selection: $fvm.dateRangeTrailing) {
                        ForEach(fvm.dateRangeLeading...getCurrentYear(), id: \.self) {
                                Text("\(String($0))").tag($0)
                            }
                    }
                }
                
                Section(header: Text("Demographic")) {
                    Picker(selection: $fvm.race, label: Text("Race")) {
                        ForEach(Races.allCases) { race in
                            Text("\(race.rawValue.capitalized)").tag(race.rawValue)
                        }
                    }
                    Picker(selection: $fvm.gender, label: Text("Gender")) {
                        Text("Any").tag("")
                        Text("Male").tag("M")
                        Text("Female").tag("F")
                    }.pickerStyle(.segmented)
                }
                Button(action: vm.updatePeopleArray(flee: fvm.flee, armed: fvm.armed, city: fvm.city, state: fvm.state, race: fvm.race, gender: fvm.gender, dateRangeLeading: fvm.dateRangeLeading, dateRangeTrailing: fvm.dateRangeTrailing)){
                    Text("Apply Filter")
                }
            }
        }
    
    }
}
    


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}




