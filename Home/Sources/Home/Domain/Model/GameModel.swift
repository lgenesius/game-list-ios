//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Foundation

public struct GameModel: Identifiable, Equatable {
    public let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let overallRating: Double
    
    var backgroundImageURL: URL? {
        guard let imageURL = self.backgroundImage else { return nil }
        let url = URL(string: imageURL)
        return url
    }
}
