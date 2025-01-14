//
//  RecipeFetchService.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import Foundation


protocol RecipeFetching {
    func fetch() async throws -> [Recipe]
}


class RecipeFetchService: RecipeFetching {
    let session: URLSession
    
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    func fetch() async throws -> [Recipe] {
        guard let url = constructURL() else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        
        guard  200..<300 ~= httpResponse.statusCode else {
            print("Response Code: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        do {
            let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
            switch recipeResponse.recipes.isEmpty {
            case true: throw URLError(.resourceUnavailable)
            case false: return recipeResponse.recipes
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func constructURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "d3jbb8n5wk0qxi.cloudfront.net"
        components.path = "/recipes.json"
        return components.url
    }
}


class RecipeFetchServiceInvalidURL: RecipeFetchService {
    override func constructURL() -> URL? { nil }
}

class RecipeFetchServiceEmptyData: RecipeFetchService {
    override func constructURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "d3jbb8n5wk0qxi.cloudfront.net"
        components.path = "/recipes-empty.json"
        return components.url
    }
}

class RecipeFetchServiceInvalidJSON: RecipeFetchService {
    override func constructURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "d3jbb8n5wk0qxi.cloudfront.net"
        components.path = "/recipes-malformed.json"
        return components.url
    }
}
