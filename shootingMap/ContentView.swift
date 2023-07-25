//
//  ContentView.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var token: Token?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
