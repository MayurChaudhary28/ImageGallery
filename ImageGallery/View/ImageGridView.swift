//
//  ImageGridView.swift
//  ImageGallery
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import SwiftUI

struct ImageGridView: View {
    @ObservedObject var viewModel = ImageGalleryViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.images.indices, id: \.self) { index in
                        let image = viewModel.images[index]
                        NavigationLink(destination: ImageDetailView(selectedIndex: index, images: viewModel.images)) {
                            ImageGridItemView(image: image)
                        }
                    }
                }
                .padding()
            }
            .task {
                // Fetch images asynchronously
                await viewModel.fetchImages()
            }
            .navigationTitle("Image Gallery")
        }
    }
}

struct ImageGridItemView: View {
    let image: ImageModel
    @State private var uiImage: UIImage? = nil
    let placeholderImage = UIImage(systemName: "photo.artframe")!
    
    var body: some View {
        Image(uiImage: uiImage ?? placeholderImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .onAppear {
                Task {
                    uiImage = await ImageGalleryViewModel().loadImage(from: image.thumbnailUrl)
                }
            }
    }
}



#Preview {
    ImageGridView()
}
