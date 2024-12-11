//
//  MainAPIResponse.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import Foundation

struct MainAPIResponse: Decodable {
    let results: [ItemResponse]
}

struct ItemResponse: Decodable {
    let id: Int
    let url: String
    let title: String
    let abstract: String
    let authorByline: String
    let publishedDate: String
    let media: [MediaResponse]
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case title
        case abstract
        case authorByline = "byline"
        case publishedDate = "published_date"
        case media
    }
}

struct MediaResponse: Decodable {
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Decodable {
    let url: String
    let format: Format
    let height: Int
    let width: Int
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

extension ItemResponse {
    func formatDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: publishedDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .long
            
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
