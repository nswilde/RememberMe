//
//  FileManager.swift
//  RememberMe
//
//  Created by Nikki Wilde on 21/10/23.
//

import UIKit

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadImage(at path: String) -> UIImage? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0]
        let imagePath = documentPath.appending(path)
        guard fileExists(at: imagePath) else {
            return nil
        }
        guard let image = UIImage(contentsOfFile: imagePath) else {
            return nil
        }
        return image
    }
    func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    func saveImage(with id: String, image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            do {
                let url = URL.documentsDirectory.appendingPathComponent("\(id).jpeg")
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Failed")
        }
    }
    
    func deleteImage(with id: String) {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpeg")
        if fileExists(atPath: url.path) {
            do {
                try removeItem(at: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("error")
        }
    }
}
