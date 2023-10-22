//
//  AddPhotoVM.swift
//  RememberMe
//
//  Created by Nikki Wilde on 22/10/23.
//

import PhotosUI
import SwiftUI

extension AddPhoto {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var image: Image?
        @Published var selectedImage: UIImage?
        @Published var imageTitle = ""
        let imageSaver = ImageSaver()
        
        
        func getImageFromName(fileName: String) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documentsDirectory.appendingPathComponent(fileName)
            
            if let imageDAta = try? Data(contentsOf: url) {
                // HERE IS YOUR IMAGE! Do what you want with it!
                let uiImage = UIImage(data: imageDAta)
                image = Image(uiImage: uiImage!)
                selectedImage = uiImage
            } else {
                print("Couldn't get image for \(fileName)")
            }
        }
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            return paths[0]
        }
        
        func save() {
            imageSaver.writeToDisk(image: selectedImage!, imageName: "image.jpeg")
        }
        
        func loadImage() {
            guard let selected = selectedImage else { return }
            
            let uiImage = UIImage()
            image = Image(uiImage: selected)
        }
    }
}
