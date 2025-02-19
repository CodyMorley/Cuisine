//
//  ImageErrorView.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI

struct ImageErrorView: View {
    let error: Error
    
    var body: some View {
        ZStack {
            Image(systemName: "photo.fill")
                .resizable()
            
            VStack {
                Text("An error was encountered fetching this photo.")
                Text("Error message: \(error.localizedDescription)")
            }
            .foregroundColor(Color(.systemRed))
            .font(.footnote)
        }
        .padding()
    }
}


#Preview {
    ImageErrorView(error: URLError(.badURL))
}
