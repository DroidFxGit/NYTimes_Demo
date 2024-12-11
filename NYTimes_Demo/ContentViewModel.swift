//
//  ContentViewModel.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchItems() {
        isLoading = true
        errorMessage = nil
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json"
        let apiKey = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
        
        apiService.fetchData(from: urlString, apiKey: apiKey, responseType: MainAPIResponse.self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    let items = response.results.compactMap { response in
                        let media = response.media.compactMap { mediaResponse in
                            let some = mediaResponse.mediaMetadata.compactMap { $0.url }.last
                            return some
                        }.first
                        
                        return Item(
                            id: "\(response.id)",
                            title: response.title,
                            description: response.abstract,
                            imageURL: media ?? "",
                            authorByline: response.authorByline,
                            publishedDate: response.formatDateString() ?? ""
                        )
                    }
                    self.items = items
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
