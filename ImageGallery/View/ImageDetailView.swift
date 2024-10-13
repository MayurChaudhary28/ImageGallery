//
//  ImageDetailView.swift
//  ImageGallery
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import SwiftUI

struct ImageDetailView: View {
    @State var selectedIndex: Int
    let images: [ImageModel]
    let placeholderImage = UIImage(systemName: "photo.artframe")!

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(0..<images.count, id: \.self) { index in
                VStack {
                    // Full-size image
                    ImageDetailContent(image: images[index])
                        .tag(index)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageDetailContent: View {
    let image: ImageModel
    @State private var uiImage: UIImage? = nil
    let placeholderImage = UIImage(systemName: "photo.artframe")!
    
    var body: some View {
        VStack {
            // Full-size image
            Image(uiImage: uiImage ?? placeholderImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 400)
                .padding()
            
            // Image title
            Text(image.title)
                .font(.title)
                .fontWeight(.medium)
                .padding()

            Spacer()
        }
        .task {
            // Asynchronously load full-size image
            uiImage = await ImageGalleryViewModel().loadImage(from: image.url)
        }
    }
}



#Preview {
    ImageDetailView(selectedIndex: 0, images: ImageModelMock.sampleImages)
}
