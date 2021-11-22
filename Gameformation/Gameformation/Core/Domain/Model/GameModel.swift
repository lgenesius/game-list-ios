//
//  GameModel.swift
//  Gameformation
//
//  Created by Luis Genesius on 22/11/21.
//

import Foundation

struct GameModel: Identifiable, Equatable {
    let id: Int
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
