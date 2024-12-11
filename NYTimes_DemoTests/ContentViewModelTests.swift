//
//  ContentViewModelTests.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 10/12/24.
//

@testable import NYTimes_Demo
import XCTest

final class ContentViewModelTests: XCTestCase {
    
    func testFetchItemsSuccess() {
        
        let jsonData = """
        {
           "results": [
               {
                  "id": 1,
                  "url": "https://example.com",
                  "title": "Test Title",
                  "byline": "Jhon Wick",
                  "abstract": "Test Description",
                  "published_date": "2024-12-09 05:01:10",
                  "media": [
                        {
                          "media-metadata": [
                             { 
                               "url": "https://example.com/image.jpg",
                               "format": "Standard Thumbnail",
                               "height": 75,
                               "width": 75
                             }
                          ]
                        }
                  ]
               }
           ]
        }
        """.data(using: .utf8)
        
        let mockSession = MockURLSession(data: jsonData, error: nil)
        let mockAPIService = APIService(session: mockSession)
        
        let viewModel = ContentViewModel(apiService: mockAPIService)
        let expectation = self.expectation(description: "Fetch items success")
        
        viewModel.fetchItems()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.items.count, 1)
            XCTAssertEqual(viewModel.items.first?.title, "Test Title")
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchItemsFailure() {
        let customError = NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        let mockSession = MockURLSession(data: nil, error: customError)
        let mockAPIService = APIService(session: mockSession)
        
        let viewModel = ContentViewModel(apiService: mockAPIService)
        let expectation = self.expectation(description: "Fetch items failure")
        
        viewModel.fetchItems()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.items.count, 0)
            XCTAssertEqual(viewModel.errorMessage, "Network error")
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
