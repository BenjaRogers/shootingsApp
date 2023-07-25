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
    @State var flee: String = ""
    @State var armed: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var race: String = ""
    @State var gender: String = ""
    @State var dateRangeLeading: Int = 2023
    @State var dateRangeTrailing: Int = 2023
    
    @EnvironmentObject var vm: PeoplesViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Location").fontWeight(.bold)) {
                    Picker(selection: $state, label: Text("State")) {
                        ForEach(States.allCases) { stateCode in
                            Text("\(stateCode.rawValue)").tag(stateCode.rawValue)
                        }
                    }
                    TextField("City", text: $city)
                }
                
                Section(header: Text("Circumstance").fontWeight(.bold)) {
                    Picker(selection: $armed, label: Text("Armed")) {
                        Text("Any").tag("")
                        Text("Armed").tag("armed")
                        Text("Unarmed").tag("unarmed")
                    }.pickerStyle(.segmented)
                    
                    Picker(selection: $flee, label: Text("Flee").fontWeight(.bold)) {
                        Text("Any").tag("")
                        Text("Fleeing").tag("fleeing")
                        Text("Not Fleeing").tag("Not+fleeing")
                    }.pickerStyle(.segmented)
                }
                Section(header: Text("Date Range").fontWeight(.bold)) {
                    Picker("From", selection: $dateRangeLeading) {
                        ForEach(2015...getCurrentYear(), id: \.self) {
                            Text("\(String($0))").tag($0)
                        }
                    }
//                            Text("2015").tag(2015)
//                            Text("2016").tag(2016)
//                            Text("2017").tag(2017)
//                            Text("2018").tag(2018)
//                            Text("2019").tag(2019)
//                            Text("2020").tag(2020)
//                            Text("2021").tag(2021)
//                            Text("2022").tag(2022)
//                            Text("2023").tag(2023)
//                        }
                        Picker("To", selection: $dateRangeTrailing) {
                            ForEach(dateRangeLeading...getCurrentYear(), id: \.self) {
                                Text("\(String($0))").tag($0)
                            }
                            
//                            Text("2015").tag(2015)
//                            Text("2016").tag(2016)
//                            Text("2017").tag(2017)
//                            Text("2018").tag(2018)
//                            Text("2019").tag(2019)
//                            Text("2020").tag(2020)
//                            Text("2021").tag(2021)
//                            Text("2022").tag(2022)
//                            Text("2023").tag(2023)
                    }
                }
                
                Section(header: Text("Demographic")) {
                    Picker(selection: $race, label: Text("Race")) {
                        ForEach(Races.allCases) { race in
                            Text("\(race.rawValue.capitalized)").tag(race.rawValue)
                        }
                    }
                    Picker(selection: $gender, label: Text("Gender")) {
                        Text("Any").tag("")
                        Text("Male").tag("M")
                        Text("Female").tag("F")
                    }.pickerStyle(.segmented)
                }
                Button(action: vm.updatePeopleArray(flee: flee, armed: armed, city: city, state: state, race: race, gender: gender, dateRangeLeading: dateRangeLeading, dateRangeTrailing: dateRangeTrailing)){
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




