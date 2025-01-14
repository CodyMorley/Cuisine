//
//  ContentViewModel.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import Observation
import SwiftUI


@Observable class ContentViewModel {
    let recipeService: any RecipeFetching
    var error: Error? = nil
    var fetchFailed: Bool = false
    var isLoading: Bool = true
    var searchText: String = ""
    private var recipes: [Recipe] = []
    
    var displayRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.contains(searchText) }
        }
    }
    
    var failureView: some View {
        VStack(spacing: 8) {
            Text("Failed to fetch recipes from host")
            Text("Error: \(error?.localizedDescription ?? "Unknown error")")
                .font(.footnote)
                .padding(.horizontal, 32)
            Button("Retry") {
                self.retry()
            }
        }
    }
    
    var loadingView: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text("Loading...")
        }
    }
    

    init(fetchService: any RecipeFetching) {
        recipeService = fetchService
    }
    
    
    func fetchRecipes() {
        Task {
            do {
                let result = try await recipeService.fetch()
                await MainActor.run {
                    recipes = result
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    fetchFailed = true
                    self.error = error
                    isLoading = false
                    recipes = []
                }
            }
        }
    }
    
    func retry() {
        fetchFailed = false
        self.error = nil
        isLoading = true
        fetchRecipes()
    }
}
