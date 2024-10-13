//
//  ImageModel.swift
//  ImageGallery
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import Foundation

struct ImageModel: Identifiable, Codable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
