//
//  ErrorView.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Something went wrong :(")
                .font(.title)
                .fontWeight(.bold)
            
            Text(errorMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button(action: retryAction) {
                Text("Retry")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    ErrorView(errorMessage: "Error Message", retryAction: {})
}
