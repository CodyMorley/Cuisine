//
//  RecipeDetailView.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI


struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack {
                Text(recipe.name)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
            
                Text("\(recipe.flag) \(recipe.cuisine) Cuisine \(recipe.flag)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                    .foregroundColor(.secondary)
            }
            
            if let imageURL = recipe.largePhotoURL {
                CachedAsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        emptyImage
                    case .failure(let error):
                        ImageErrorView(error: error).frame(width: 380, height: 380)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 380, height: 380)
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                    @unknown default:
                        fatalError("An unknown AsyncImage phase occurred")
                    }
                }
            } else {
                emptyImage
            }
            
            HStack(alignment: .center, spacing: 64) {
                if let yt = recipe.youtubeURL {
                    VStack {
                        Link(destination: yt) {
                            Image(systemName: "play.square.fill")
                                .resizable()
                                .frame(width: 128, height: 64)
                                .foregroundStyle(.red)
                        }
                        
                        Text("Watch on YouTube")
                            .font(.headline)
                    }
                }
                
                if let src = recipe.sourceURL {
                    VStack {
                        Link(destination: src) {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .foregroundStyle(.blue)
                        }
                        
                        Text("View Recipe")
                            .font(.headline)
                    }
                }
            }
        }
    }
    
    var emptyImage: some View {
        ZStack {
            Image(systemName: "photo.fill")
                .resizable()
                .cornerRadius(12)
                .padding(.horizontal, 16)
        }
        .frame(width: 380, height: 180)
    }
}


#Preview {
    RecipeDetailView(recipe: MockData.sample)
}
