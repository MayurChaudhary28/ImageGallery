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
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selectedIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    ImageDetailContent(image: images[index], screenSize: geometry.size)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationBarTitleDisplayMode(.inline)
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
}

struct ImageDetailContent: View {
    let image: ImageModel
    let screenSize: CGSize
    @State private var uiImage: UIImage? = nil
    @State private var isZoomed = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Full-size image or smaller placeholder
                Group {
                    if let uiImage = uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Image("placeholderIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: screenSize.width, height: screenSize.height * 0.6)
                .clipped()
                
                VStack(alignment: .leading, spacing: 15) {
                    // Image title
                    Text(image.title)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
        }
        .task {
            uiImage = await ImageGalleryViewModel().loadImage(from: image.url)
        }
    }
}

#Preview {
    ImageDetailView(selectedIndex: 0, images: ImageModelMock.sampleImages)
}
