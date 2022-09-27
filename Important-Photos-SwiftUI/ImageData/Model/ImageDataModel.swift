//
//  ImageDataModel.swift
//  Important-Photos-SwiftUI
//
//  Created by Jonas Bergström on 2022-09-27.
//

import Foundation
import SwiftUI

struct ImageNote : Codable, Hashable, Identifiable {
    var id = UUID()
    var image: Data
    var title: String
    var description: String
}

@MainActor class ImageData : ObservableObject {
    private let IMAGES_KEY = "KeyForImages"
    var imageNote: [ImageNote] {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: IMAGES_KEY) {
            if let decodedNotes = try? JSONDecoder().decode([ImageNote].self, from: data) {
                imageNote = decodedNotes
                print("The note data retreived successfully!")
                return
            }
        }
        imageNote = []
    }
    
    func addNote(image: UIImage, title: String, description: String) {
        if let pngRepresentation = image.pngData() {
            let tempNote = ImageNote(image: pngRepresentation, title: title, description: description)
            imageNote.insert(tempNote, at: 0)
            print("Added note!")
        }
    }
}
