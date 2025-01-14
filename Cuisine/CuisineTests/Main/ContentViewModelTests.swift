//
//  ContentViewModelTests.swift
//  CuisineTests
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI
import XCTest
@testable import Cuisine


final class ContentViewModelTests: XCTestCase {
    var sut: ContentViewModel!
    var mockRecipeService: MockRecipeFetcher!
    
    
    override func setUp() {
        super.setUp()
        mockRecipeService = MockRecipeFetcher()
        sut = ContentViewModel(fetchService: mockRecipeService)
    }
    
    override func tearDown() {
        sut = nil
        mockRecipeService = nil
        super.tearDown()
    }
    
    
    func testInitialState() {
        XCTAssertTrue(sut.isLoading)
        XCTAssertFalse(sut.fetchFailed)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.searchText, "")
        XCTAssertEqual(sut.displayRecipes.count, 0)
    }
    
    
    func testSuccessfulRecipeFetch() async {
        let testRecipes = MockData.recipes
        mockRecipeService.mockResult = .success(testRecipes)
        
        sut.fetchRecipes()
        await fulfillment(of: [mockRecipeService.fetchCalled], timeout: 1.0)
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.fetchFailed)
        XCTAssertEqual(sut.displayRecipes, testRecipes)
    }
    
    func testFailedRecipeFetch() async {
        let testError = NSError(domain: "test", code: 1)
        mockRecipeService.mockResult = .failure(testError)
        
        sut.fetchRecipes()
        await fulfillment(of: [mockRecipeService.fetchCalled], timeout: 1.0)
        
        await MainActor.run {
            XCTAssertFalse(sut.isLoading)
            XCTAssertTrue(sut.fetchFailed)
            XCTAssertNotNil(sut.error)
            XCTAssertEqual(sut.displayRecipes.count, 0)
        }
    }
    
    func testSearchFiltering() async {
        let recipes = MockData.recipes
        mockRecipeService.mockResult = .success(recipes)
        sut.fetchRecipes()
        
        await fulfillment(of: [mockRecipeService.fetchCalled], timeout: 1.0)
        await MainActor.run { sut.searchText = "ap" }
        
        XCTAssertEqual(sut.displayRecipes.count, 3)
        XCTAssertTrue(sut.displayRecipes.contains { $0.name == "Apam Balik" })
        XCTAssertTrue(sut.displayRecipes.contains { $0.name == "Apple & Blackberry Crumble" })
    }
    
    func testEmptySearchShowsAllRecipes() async {
        let recipes = MockData.recipes
        mockRecipeService.mockResult = .success(recipes)
        
        sut.fetchRecipes()
        await fulfillment(of: [mockRecipeService.fetchCalled], timeout: 1.0)
        await MainActor.run { sut.searchText = "" }
        
        XCTAssertEqual(sut.displayRecipes.count, 6)
    }
    
    func testRetryResetsFetchState() {
        sut.fetchFailed = true
        sut.error = NSError(domain: "test", code: 1)
        sut.isLoading = false
        
        sut.retry()
        
        XCTAssertTrue(sut.isLoading)
        XCTAssertFalse(sut.fetchFailed)
        XCTAssertNil(sut.error)
    }
}


class MockRecipeFetcher: RecipeFetching {
    var mockResult: Result<[Recipe], Error>?
    var fetchCalled = XCTestExpectation()
    
    
    func fetch() async throws -> [Recipe] {
        defer { fetchCalled.fulfill() }
        guard let mockResult else { throw NSError(domain: "test", code: 1) }
        
        switch mockResult {
        case .success(let recipes):
            return recipes
        case .failure(let error):
            throw error
        }
    }
}
