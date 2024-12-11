//
//  ItemDetailView.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 10/12/24.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        ScrollView {
            VStack {
                // Image
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: item.imageURL)) { phase in
                        switch phase {
                        case .empty:
                            if phase.image != nil {
                                ProgressView()
                                    .frame(height: 300)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 300)
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 300)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .overlay(
                        // Overlayed Title
                        Text(item.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(8)
                            .padding(),
                        alignment: .bottom
                    )
                }
                
                // Additional Info
                VStack(alignment: .leading, spacing: 12) {
                    Text(item.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("Author:")
                            .fontWeight(.bold)
                        Text(item.authorByline)
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Text("Published:")
                            .fontWeight(.bold)
                        Text(item.publishedDate)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ItemDetailView(
        item: .init(
            id: "1",
            title: "Some title",
            description: "Some description goes here",
            imageURL: "https://example.com",
            authorByline: "Jhon Wick",
            publishedDate: "01/01/2025"
        )
    )
}
