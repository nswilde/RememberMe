//
//  ContentView.swift
//  RememberMe
//
//  Created by Nikki Wilde on 17/10/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    //saveToDocs()
                } label: {
                    Text("Save")
                }
            }
            .navigationTitle("RememberMe")
        }
    }
}

#Preview {
    ContentView()
}
