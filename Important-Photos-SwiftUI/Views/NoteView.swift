//
//  NoteView.swift
//  Important-Photos-SwiftUI
//
//  Created by Jonas Bergström on 2022-09-27.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var imageData : ImageData
    @State var note: ImageNote
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(uiImage: UIImage(data: note.image)!)
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                    Spacer()
                }
                TextField("Edit note", text: $note.title)
                    .textSelection(.enabled)
                    .onTapGesture {
                        note.title = ""
                    }
                ZStack {
                    TextEditor(text: $note.description)
                        .textSelection(.enabled)
                        .frame(height: 200)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(note.description.count)/120")
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button("Save changes") {
                        imageData.editNote(id: note.id, title: note.title, description: note.description)
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let tempImage = UIImage(systemName: "map")?.pngData()
        NoteView(note: ImageNote(id: UUID(), image: tempImage!, title: "Test", description: "Test Description"))
            .environmentObject(ImageData())
    }
}
