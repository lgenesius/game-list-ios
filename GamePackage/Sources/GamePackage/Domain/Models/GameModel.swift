//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

public struct GameModel: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let released: String?
    public let backgroundImage: String?
    public let overallRating: Double
    
    public init(id: Int, name: String, released: String?, backgroundImage: String?, overallRating: Double) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.overallRating = overallRating
    }
    
    var backgroundImageURL: URL? {
        guard let imageURL = self.backgroundImage else { return nil }
        let url = URL(string: imageURL)
        return url
    }
}
