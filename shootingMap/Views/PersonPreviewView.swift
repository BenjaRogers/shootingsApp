//
//  PersonPreviewView.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/11/23.
//

import SwiftUI

struct PersonPreviewView: View {
    @EnvironmentObject private var vm: PeoplesViewModel
    let person: Person

    var body: some View {
        HStack(alignment: .bottom, spacing: 4.0) {
            VStack(alignment: .leading, spacing: 16) {
                titleSection
            }
            Spacer()
            VStack(spacing: 15) {
                ButtonSection
            }
        }.padding(20)
            .background(RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial))
    }
}

struct PersonPreviewView_Previews: PreviewProvider {
    let person = shootAPI().fetchAPIPerson()?.people.first
    static var previews: some View {
        PersonPreviewView(person: (shootAPI().fetchAPISinglePerson(id: 3)?.people)!)
    }
}

extension PersonPreviewView {
    private var titleSection: some View {
            VStack(alignment: .leading, spacing: 4) {
//                if person.name != nil {
                    Text(person.name ?? "NA").font(.title2).fontWeight(.bold)
//                } else {
//                    Text("N/A").font(.title2).fontWeight(.bold)
//                }
                if person.city != nil {
                    Text("\(person.city!) , \(person.state!)").font(.subheadline)
                } else {
                    Text("N/A").font(.subheadline)
                }
        }
    }
    
    private var ButtonSection: some View {
        VStack(alignment: .trailing, spacing: 8) {
            Button {
                vm.personDetails = person
            } label: {
                Text("More Info")
                    .font(.headline)
                    .frame(width: 125, height: 35)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
