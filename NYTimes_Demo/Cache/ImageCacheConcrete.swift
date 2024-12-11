//
//  ImageCache.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import SwiftUI
import Foundation

protocol ImageCache {
    func object(forKey key: NSURL) -> UIImage?
    func setObject(_ obj: UIImage, forKey key: NSURL)
}

final class ImageCacheConcrete: ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
    
    func object(forKey key: NSURL) -> UIImage? {
        Self.shared.object(forKey: key)
    }
    
    func setObject(_ obj: UIImage, forKey key: NSURL) {
        Self.shared.setObject(obj, forKey: key)
    }
}
