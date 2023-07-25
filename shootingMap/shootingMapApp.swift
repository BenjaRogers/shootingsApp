//
//  shootingMapApp.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/8/23.
//

import SwiftUI

@main
struct shootingMapApp: App {
    @StateObject private var vm = PeoplesViewModel(peopleArray: shootAPI().fetchAPIParamPerson(flee: "" , armed: "", city: "", state: "", race: "", gender: "", dateRangeLeading: 2023, dateRangeTrailing: 2023)!)
    var body: some Scene {
        WindowGroup {
            PeoplesView().environmentObject(vm)
        }
    }
}
