//
//  MockURLSession.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 10/12/24.
//

import Foundation
@testable import NYTimes_Demo

final class MockURLSession: URLSessionProtocol {
    private let data: Data?
    private let error: Error?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        completionHandler(data, nil, error)
        return URLSession.shared.dataTask(with: url)
    }
}
