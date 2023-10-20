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
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var imageTitle = ""
    
    @State private var filterIntensity = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    let imageSaver = ImageSaver()
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    
    private var url: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("image.jpg")
    }

    
  
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                    
                    
                    

                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    TextField("Image title", text: $imageTitle)
                }
                
                HStack {
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                                applyProcessing()
                            }
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        save()
                    }
                    
                    Button("Load") {
                        getImageFromName(fileName: "image.jpeg")
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func getImageFromName(fileName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let imageData = try? Data(contentsOf: url) {
            // HERE IS YOUR IMAGE! Do what you want with it!
            let uiImage = UIImage(data: imageData)
            image = Image(uiImage: uiImage!)
                processedImage = uiImage
        } else {
            print("Couldn't get image for \(fileName)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
    
        func save() {
            imageSaver.writeToDisk(image: inputImage!, imageName: "image.jpeg")
        }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }


        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    
    func setFilter(_ filter: CIFilter) {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
    }
    
    func applyProcessing() {
        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
}
    
#Preview {
    ContentView()
}
