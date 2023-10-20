//
//  LoadImage.swift
//  RememberMe
//
//  Created by Nikki Wilde on 21/10/23.
//

import Foundation
import UIKit

extension URL {
    func loadImage(_ image: inout UIImage?) {
            if let data = try? Data(contentsOf: self), let loaded = UIImage(data: data) {
                image = loaded
            } else {
                image = nil
            }
        }
}
