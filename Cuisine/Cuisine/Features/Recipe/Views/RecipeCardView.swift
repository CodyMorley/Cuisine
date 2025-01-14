//
//  RecipeCardView.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI


struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        if let imageURL = recipe.largePhotoURL {
            ZStack {
                CachedAsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty: emptyImage
                    case .failure(let error): ImageErrorView(error: error)
                    case .success(let image):
                        image
                            .resizable()
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                    @unknown default: fatalError("An unknown AsyncImage phase occurred")
                    }
                }
                
                Text(recipe.name)
                    .multilineTextAlignment(.leading)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .font(.title2)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .padding(.top, 120)
                    .padding(.horizontal, 16)
            }
            .frame(width: 380, height: 180)
        } else {
            emptyImage
        }
    }
    
    var emptyImage: some View {
        ZStack {
            Image(systemName: "photo.fill")
                .resizable()
                .cornerRadius(12)
                .padding(.horizontal, 16)
            
            Text(recipe.name)
                .multilineTextAlignment(.leading)
                .fontDesign(.serif)
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 120)
        }
        .frame(width: 380, height: 180)
    }
}


#Preview {
    RecipeCardView(recipe: MockData.sample)
}
