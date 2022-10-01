//
//  HomeView.swift
//  Important-Photos-SwiftUI
//
//  Created by Jonas Bergström on 2022-09-27.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var imageData: ImageData
    var body: some View {
        List {
            ForEach(imageData.imageNote) { note in
                NavigationLink(destination: NoteView(note: note)) {
                    HStack {
                        Image(uiImage: UIImage(data: note.image)!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .lineLimit(2)
                        }
                    }
                }
            }
            .onDelete(perform:  { indexSet in
                imageData.imageNote.remove(atOffsets: indexSet)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ImageData())
    }
}
