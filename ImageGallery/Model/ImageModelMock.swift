//
//  ImageModelMock.swift
//  ImageGallery
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import Foundation

// Mock Data for ImageModel
struct ImageModelMock {
    
    static let sampleImages: [ImageModel] = [
        ImageModel(id: 1, title: "Sample Image 1", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        ImageModel(id: 2, title: "Sample Image 2", url: "https://via.placeholder.com/600/771796", thumbnailUrl: "https://via.placeholder.com/150/771796"),
        ImageModel(id: 3, title: "Sample Image 3", url: "https://via.placeholder.com/600/24f355", thumbnailUrl: "https://via.placeholder.com/150/24f355")
    ]
    
    static let singleImage: ImageModel = ImageModel(id: 1, title: "Sample Image 1", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952")
}
