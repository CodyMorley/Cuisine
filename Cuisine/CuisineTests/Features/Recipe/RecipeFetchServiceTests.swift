//
//  RecipeFetchServiceTests.swift
//  CuisineTests
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI
import XCTest
@testable import Cuisine


final class RecipeFetchServiceTests: XCTestCase {
    func testFetchRecipesSuccess() async throws {
        let expectedRecipes = MockData.recipes
        let mockData = try JSONEncoder().encode(RecipeResponse(recipes: expectedRecipes))
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
        
        MockURLProtocol.requestHandler = { request in
            (mockResponse, mockData)
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let fetcher = RecipeFetchService(session: session)
        let recipes = try await fetcher.fetch()
        
        XCTAssertEqual(recipes, expectedRecipes)
    }
    
    func testFetchRecipesInvalidURL() async {
        let fetcher = RecipeFetchServiceInvalidURL()
        
        do {
            _ = try await fetcher.fetch()
            XCTFail("Expected to throw URLError.badURL, but succeeded.")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badURL)
        } catch {
            XCTFail("Expected URLError.badURL, got \(error)")
        }
    }
    
    func testFetchRecipesServerError() async throws {
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 500,
                                           httpVersion: nil,
                                           headerFields: nil)!
        MockURLProtocol.requestHandler = { request in
            return (mockResponse, Data())
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let fetcher = RecipeFetchService(session: session)
        
        do {
            _ = try await fetcher.fetch()
            XCTFail("Expected to throw, but succeeded.")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
    
    
    
    func testFetchRecipesHTTPErrorStatus() async {
        let mockData = Data()
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 404,
                                           httpVersion: nil,
                                           headerFields: nil)!
        
        MockURLProtocol.requestHandler = { request in
            (mockResponse, mockData)
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let fetcher = RecipeFetchService(session: session)
        
        do {
            _ = try await fetcher.fetch()
            XCTFail("Expected to throw URLError.badServerResponse, but succeeded.")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badServerResponse)
        } catch {
            XCTFail("Expected URLError.badServerResponse, got \(error)")
        }
    }
    
    func testFetchRecipesDecodingFailure() async {
        let invalidData = "Invalid JSON".data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
        
        MockURLProtocol.requestHandler = { request in
            return (mockResponse, invalidData)
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let fetcher = RecipeFetchService(session: session)
        
        do {
            _ = try await fetcher.fetch()
            XCTFail("Expected to throw decoding error, but succeeded.")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
}

