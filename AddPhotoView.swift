//
//  AddPhotoView.swift
//  RememberMe
//
//  Created by Nikki Wilde on 18/10/23.
//

import PhotosUI
import SwiftUI

struct AddPhotoView: View {
    @State private var image: Image?
    @State public var selectedPhoto: PhotosPickerItem?
    @State var imageTitle = ""
    @State var imageDetails = ""

    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                        .scaledToFit()
                    
                    image?
                        .resizable()
                        .scaledToFit()
                    
                    PhotosPicker(selection: $selectedPhoto,
                                 matching: .images
                    ) {
                        if image == nil {
                            Text("Select photo")
                        }
                    }
                }
                .padding(.vertical)
                .task(id: selectedPhoto) {
                        image = try? await selectedPhoto?.loadTransferable(type: Image.self)
                }
                

                Section("Image details") {
                    VStack(alignment: .leading) {
                        TextField("Name your photo", text: $imageTitle)
                        
                        TextField("Add a description", text: $imageDetails)
                    }
                    .padding()
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("RememberMe")
            //.alert("Oops!", isPresented: $showingSaveError) {
             //   Button("OK") { }
            //} message: {
                //Text("There was an error saving your image, please check that you have allowed permissions.")
           // }
        }
    }
    
    func writeToDisk() {
        guard let image = image else { return }
            let savePath = FileManager.documentsDirectory.appendingPathComponent("\(imageTitle).jpg") //Where are I want to store my data
        let Data = ImageData(id: UUID(), image: image, imageName: imageTitle, imageDesc: imageDetails)
        }
    }

#Preview {
    AddPhotoView()
}
