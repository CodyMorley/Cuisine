//
//  CuisineApp.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI

// For end to end testing of bad-path scenarios, use RecipeFetchServiceEmptyData() or RecipeFetchServiceInvalidJSON() instead.

@main
struct CuisineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(fetchService: RecipeFetchService()))
        }
    }
}
