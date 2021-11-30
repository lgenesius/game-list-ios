//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

public struct GameModel: Identifiable, Equatable {
    public let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let overallRating: Double
    
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
