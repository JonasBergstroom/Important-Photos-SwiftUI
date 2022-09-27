//
//  ContentView.swift
//  Important-Photos-SwiftUI
//
//  Created by Jonas Bergström on 2022-09-26.
//

import SwiftUI

struct ContentView: View {
    @State var showImagePicker: Bool = false
    @StateObject var imageData = ImageData()
    
    var body: some View {
        NavigationView {
            VStack {
                if imageData.imageNote.isEmpty {
                    Text("Add a photo from your library")
                        .font(.callout)
                        .fontWeight(.thin)
                        .italic()
                        .foregroundColor(.blue)
        
                } else {
                    HomeView()
                }
            }
            .navigationTitle("Photos with notes")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) {
                    image in
                    imageData.addNote(image: image, title: "Edit note", description: "")
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Label("Image", systemImage: "photo.on.rectangle.angled")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            imageData.clearUserData()
                        }
                    } label: {
                        Label("Delete", systemImage: "folder.badge.minus")
                            .tint(.red)
                    }
                }
            }
        }
        .environmentObject(imageData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
