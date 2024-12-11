//
//  MockImageCache.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 10/12/24.
//

import Foundation
@testable import NYTimes_Demo
import UIKit

final class MockImageCache: ImageCache {
    var cachedImages: [NSURL: UIImage] = [:]
    
    func object(forKey key: NSURL) -> UIImage? {
        return cachedImages[key]
    }
    
    func setObject(_ obj: UIImage, forKey key: NSURL) {
        cachedImages[key] = obj
    }
}
