//
//  ImageSaver.swift
//  RememberMe
//
//  Created by Nikki Wilde on 21/10/23.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    func writeToDisk(image: UIImage, imageName: String) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent("image.jpeg") //Where are I want to store my data
            if let jpegData = image.jpegData(compressionQuality: 0.5) { // I can adjust the compression quality.
                try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
            }
        }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
