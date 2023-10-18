//
//  FileManager.swift
//  RememberMe
//
//  Created by Nikki Wilde on 18/10/23.
//

import Foundation
import UIKit

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
