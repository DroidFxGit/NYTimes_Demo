//
//  ItemRow.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import SwiftUI

struct ItemRow: View {
    let item: Item
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        HStack(alignment: .top) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
            } else if imageLoader.isLoading {
                ProgressView()
                    .frame(width: 50, height: 50)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            if let url = URL(string: item.imageURL) {
                imageLoader.loadImage(from: url)
            }
        }
    }
}

#Preview {
    ItemRow(
        item: .init(
            id: "1",
            title: "Example",
            description: "some description goes here",
            imageURL: "https://example.com",
            authorByline: "Jhon Wick",
            publishedDate: "01/01/2025"
        )
    )
}
