//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation
import Core

public struct GameMapper {
    
    public static func mapGameToGameModel(_ games: [Game]) -> [GameModel] {
        return games.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                overallRating: result.overallRating
            )
        }
    }
}
