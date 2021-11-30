//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

public struct DetailGameModel: Identifiable {
    public let id: Int
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

public struct PlatformModel: Identifiable {
    public let id: Int
    let name: String
}

public struct PublisherModel: Identifiable {
    public let id: Int
    let name: String
    let imageBackground: String
}
