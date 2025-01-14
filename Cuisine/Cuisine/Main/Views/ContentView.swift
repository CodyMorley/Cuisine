//
//  ContentView.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import Observation
import SwiftUI


struct ContentView: View {
    @State private var vm: ContentViewModel
    
    
    init(viewModel: ContentViewModel) {
        vm = viewModel
    }
    
    
    var body: some View {
        NavigationStack {
            if vm.isLoading {
                vm.loadingView
            } else if vm.fetchFailed {
                vm.failureView
            } else {
                ScrollView {
                    ForEach(vm.displayRecipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                        } label: {
                            RecipeCardView(recipe: recipe)
                        }
                    }
                }
                .navigationTitle("🍽️  Cuisine  🍽️")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $vm.searchText)
            }
        }
        .task {
            vm.fetchRecipes()
        }
    }
}


#Preview {
    ContentView(viewModel: ContentViewModel(fetchService: RecipeFetchService()))
}
