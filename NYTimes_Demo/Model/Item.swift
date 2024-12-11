//
//  Item.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import Foundation

public struct Item: Identifiable {
    public let id: String
    public let title: String
    public let description: String
    public let imageURL: String
    public let authorByline: String
    public let publishedDate: String
}
