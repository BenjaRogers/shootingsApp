//
//  MapAnnotationView.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/10/23.
//

import SwiftUI

struct PersonMapAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin").resizable().scaledToFit().frame(width:15, height:15)
        }
    }
}

struct PersonMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonMapAnnotationView()
    }
}
