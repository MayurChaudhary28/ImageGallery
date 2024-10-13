//
//  APIConstants.swift
//  ImageGallery
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import Foundation
struct APIConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let photosEndpoint = "/photos"
    
    static var photosURL: String {
        return baseURL + photosEndpoint
    }
}
