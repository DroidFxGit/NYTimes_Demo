//
//  ContentView.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel(
        apiService: APIService(
            session: URLSession.shared
        )
    )
    @State private var selectedItem: Item? = nil
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .scaleEffect(1.5)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(errorMessage: errorMessage) {
                        viewModel.fetchItems()
                    }
                } else {
                    List(viewModel.items) { item in
                        Button(action: {
                            selectedItem = item
                        }) {
                            ItemRow(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.fetchItems()
            }
            .sheet(item: $selectedItem) { item in
                NavigationView {
                    ItemDetailView(item: item)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
