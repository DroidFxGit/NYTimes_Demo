//
//  ImageLoader.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 10/12/24.
//

import Foundation
import UIKit

final class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cache: ImageCache
    private var session: URLSessionProtocol
    
    init(
        session: URLSessionProtocol = URLSession.shared,
        cache: ImageCache = ImageCacheConcrete()
    ) {
        self.session = session
        self.cache = cache
    }
    
    func loadImage(from url: URL) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        
        self.isLoading = true
        
        session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                self?.isLoading = false
                return
            }
            
            DispatchQueue.main.async {
                self.cache.setObject(image, forKey: url as NSURL)
                self.image = image
                self.isLoading = false
            }
        }.resume()
    }
}
