//
//  ImageGalleryTests.swift
//  ImageGalleryTests
//
//  Created by Mayur Chaudhary on 13/10/24.
//

import XCTest
@testable import ImageGallery

final class ImageGalleryTests: XCTestCase {
    
    var viewModel: ImageGalleryViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        await MainActor.run {
            viewModel = ImageGalleryViewModel()
        }
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() async {
        let images = await viewModel.images
        XCTAssertTrue(images.isEmpty)
    }
    
     func testFetchImagesSuccess() async throws {
        await viewModel.fetchImages()
        
        // Wait for a short time to allow the fetch to complete
        try await Task.sleep(for: .seconds(2))
        
        let images = await viewModel.images
        XCTAssertFalse(images.isEmpty)
    }
}
