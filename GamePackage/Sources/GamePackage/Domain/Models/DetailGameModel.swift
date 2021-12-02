//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

public struct DetailGameModel: Identifiable {
    public let id: Int
    public let name: String
    public let released: String?
    public let backgroundImage: String?
    public let overallRating: Double
    public let platforms: [PlatformModel]?
    public let publishers: [PublisherModel]?
    public let gameDescription: String?
    
    public var backgroundImageURL: URL? {
        guard let imageURL = self.backgroundImage else { return nil }
        let url = URL(string: imageURL)
        return url
    }
}

public struct PlatformModel: Identifiable {
    public let id: Int
    public let name: String
}

public struct PublisherModel: Identifiable {
    public let id: Int
    public let name: String
    public let imageBackground: String
}
