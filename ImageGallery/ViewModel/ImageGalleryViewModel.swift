//
//  ImageGalleryViewModel.swift
//  ImageGallery
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import Foundation
import UIKit
import SwiftUI

@MainActor
class ImageGalleryViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var selectedImage: ImageModel?
    
    private let url = "https://jsonplaceholder.typicode.com/photos"
    
    /// Fetch images using async/await
    func fetchImages() async {
        guard let requestUrl = URL(string: url) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: requestUrl)
            let decodedImages = try JSONDecoder().decode([ImageModel].self, from: data)
            self.images = decodedImages
        } catch {
            print("Error fetching images: \(error)")
        }
    }
    
    /// Load an image using async/await and check cache
    func loadImage(from urlString: String) async -> UIImage? {
        if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                ImageCache.shared.saveImage(image, forKey: urlString)
                return image
            }
        } catch {
            print("Error loading image: \(error)")
        }
        
        return nil
    }
}
