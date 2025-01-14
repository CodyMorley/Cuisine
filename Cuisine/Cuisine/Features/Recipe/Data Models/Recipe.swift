//
//  Recipe.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import Foundation


struct RecipeResponse: Codable {
    let recipes: [Recipe]
}


struct Recipe: Codable, Equatable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case id = "uuid"
        case largePhotoURL = "photo_url_large"
        case smallPhotoURL = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }

    
    let id: UUID
    let cuisine: String
    let name: String
    let largePhotoURL: URL?
    let smallPhotoURL: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    var flag: String {
        switch cuisine {
        case "American": return "🇺🇸"
        case "British": return "🇬🇧"
        case "Canadian": return "🇨🇦"
        case "Croatian": return "🇭🇷"
        case "French": return "🇫🇷"
        case "Greek": return "🇬🇷"
        case "Italian": return "🇮🇹"
        case "Malaysian": return "🇲🇾"
        case "Polish": return "🇵🇱"
        case "Portuguese": return "🇵🇹"
        case "Russian": return "🇷🇺"
        case "Tunisian": return "🇹🇳"
        default : return "🌎"
        }
    }
    
    
    init(id: UUID, cuisine: String, name: String, largePhotoURL: URL?, smallPhotoURL: URL?, sourceURL: URL?, youtubeURL: URL?) {
        self.id = id
        self.cuisine = cuisine
        self.name = name
        self.largePhotoURL = largePhotoURL
        self.smallPhotoURL = smallPhotoURL
        self.sourceURL = sourceURL
        self.youtubeURL = youtubeURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let idString = try container.decode(String.self, forKey: .id)
        guard let uuid = UUID(uuidString: idString) else {
            throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "Invalid UUID")
        }
        id = uuid
        
        cuisine = try container.decode(String.self, forKey: .cuisine)
        name = try container.decode(String.self, forKey: .name)
        
        largePhotoURL = try container.decodeIfPresent(String.self, forKey: .largePhotoURL).flatMap { URL(string: $0) }
        smallPhotoURL = try container.decodeIfPresent(String.self, forKey: .smallPhotoURL).flatMap { URL(string: $0) }
        sourceURL = try container.decodeIfPresent(String.self, forKey: .sourceURL).flatMap { URL(string: $0) }
        youtubeURL = try container.decodeIfPresent(String.self, forKey: .youtubeURL).flatMap { URL(string: $0) }
    }
}
