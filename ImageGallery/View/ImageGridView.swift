//
//  ImageGridView.swift
//  ImageGallery
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import SwiftUI

struct ImageGridView: View {
    @StateObject var viewModel = ImageGalleryViewModel()
    // Adjust the grid layout for better spacing
    let columns = [GridItem(.adaptive(minimum: 150, maximum: 200))]
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.images.isEmpty {
                    ProgressView("Loading images...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.images.indices, id: \.self) { index in
                                let image = viewModel.images[index]
                                NavigationLink(destination: ImageDetailView(selectedIndex: index, images: viewModel.images)) {
                                    ImageGridItemView(image: image)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                if viewModel.images.isEmpty {
                    Task {
                        await viewModel.fetchImages()
                    }
                }
            }
            .navigationTitle("Image Gallery")
            // Add a refresh control
            .refreshable {
                await viewModel.fetchImages()
            }
        }
    }
}

struct ImageGridItemView: View {
    let image: ImageModel
    @State private var uiImage: UIImage? = nil

    var body: some View {
        VStack {
            if let loadedImage = uiImage {
                Image(uiImage: loadedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
            } else {
                PlaceholderImageView()
            }
            
            Text(image.title)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
        }
        .frame(height: 200)
        .onAppear {
            Task {
                uiImage = await ImageGalleryViewModel().loadImage(from: image.thumbnailUrl)
            }
        }
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .foregroundColor(.gray)
    }
}

#Preview {
    ImageGridView()
}
