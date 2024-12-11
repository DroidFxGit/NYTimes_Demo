//
//  ImageLoaderTests.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 10/12/24.
//

import XCTest
@testable import NYTimes_Demo

final class ImageLoaderTests: XCTestCase {
    var imageLoader: ImageLoader!
    var mockCache: MockImageCache!
    var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockCache = MockImageCache()
        
        let image = UIImage(color: .red, size: CGSize(width: 100, height: 100))
        let data = image.pngData()
        mockSession = MockURLSession(data: data, error: nil)
        imageLoader = ImageLoader(session: mockSession, cache: mockCache)
    }
    
    override func tearDown() {
        super.tearDown()
        mockCache = nil
        mockSession = nil
        imageLoader = nil
    }
    
    func testImageLoadingFromCache() {
        //simulate image is already in Cache
        let imageUrl = URL(string: "https://example.com/image.png")!
        let cachedImage = UIImage()
        mockCache.setObject(cachedImage, forKey: imageUrl as NSURL)
        
        imageLoader.loadImage(from: imageUrl)
        
        XCTAssertEqual(imageLoader.image, cachedImage)
        XCTAssertFalse(imageLoader.isLoading)
    }
    
    func testImageLoadingFromNetworking() {
        let imageUrl = URL(string: "https://example.com/image.png")!

        let expectation = self.expectation(description: "Image loading from networking")
        imageLoader.loadImage(from: imageUrl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.imageLoader.image)
            XCTAssertFalse(self.imageLoader.isLoading)
            XCTAssertNotNil(self.mockCache.cachedImages[imageUrl as NSURL])
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testImageLoadingWithError() {
        let imageUrl = URL(string: "https://example.com/image.png")!
        let error = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        mockSession = MockURLSession(data: nil, error: error)
        imageLoader = ImageLoader(session: mockSession, cache: mockCache)
        
        let expectation = self.expectation(description: "Image loading with error")
        
        imageLoader.loadImage(from: imageUrl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.imageLoader.image)
            XCTAssertFalse(self.imageLoader.isLoading)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}

// For mock purpose
extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image!.cgImage!)
    }
}
