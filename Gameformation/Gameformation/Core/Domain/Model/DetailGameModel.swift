//
//  GameModel.swift
//  Gameformation
//
//  Created by Luis Genesius on 22/11/21.
//

import Foundation

struct DetailGameModel: Identifiable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let overallRating: Double
    let platforms: [PlatformModel]?
    let publishers: [PublisherModel]?
    let gameDescription: String?
    
    var backgroundImageURL: URL? {
        guard let imageURL = self.backgroundImage else { return nil }
        let url = URL(string: imageURL)
        return url
    }
}

struct PlatformModel: Identifiable {
    let id: Int
    let name: String
}

struct PublisherModel: Identifiable {
    let id: Int
    let name: String
    let imageBackground: String
}
