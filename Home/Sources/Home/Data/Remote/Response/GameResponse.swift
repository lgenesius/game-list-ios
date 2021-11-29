//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Foundation

public struct GameResponse: Codable {
    let next: String?
    let previous: String?
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case next
        case previous
        case games = "results"
    }
    
    var nextURL: URL? {
        guard let nextString = next else { return nil }
        guard let url = URL(string: nextString) else { return nil }
        return url
    }
}

public struct Game: Codable, Identifiable {
    public let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let overallRating: Double
    let platforms: [Platform]?
    let publishers: [Publisher]?
    let gameDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case overallRating = "rating"
        case platforms
        case publishers
        case gameDescription = "description_raw"
    }
    
    var backgroundImageURL: URL? {
        guard let imageURL = self.backgroundImage else { return nil }
        let url = URL(string: imageURL)
        return url
    }
}

public struct Platform: Codable, Hashable {
    let platform: DetailPlatform
}

public struct DetailPlatform: Codable, Hashable {
    let id: Int
    let name: String
}

public struct Publisher: Codable, Hashable {
    let id: Int
    let name: String
    let imageBackground: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageBackground = "image_background"
    }
}
