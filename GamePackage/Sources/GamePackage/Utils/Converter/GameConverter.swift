//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

public struct GameConverter {
    
    public static func convertGameToDetailGameModel(_ game: Game) -> DetailGameModel {
        return DetailGameModel(
            id: game.id,
            name: game.name,
            released: game.released,
            backgroundImage: game.backgroundImage,
            overallRating: game.overallRating,
            platforms: PlatformMapper.mapPlatformToPlatformModel(game.platforms ?? []),
            publishers: PublisherMapper.mapPublisherToPublisherModel(game.publishers ?? []),
            gameDescription: game.gameDescription)
    }
    
    public static func fromGameEntitytoDetailGameModel(_ game: GameEntity?) -> DetailGameModel? {
        guard let game = game else { return nil }
        return DetailGameModel(
            id: Int(game.id),
            name: game.name ?? "Unknown",
            released: game.released,
            backgroundImage: game.backgroundImage,
            overallRating: game.overallRating,
            platforms: nil,
            publishers: nil,
            gameDescription: nil
        )
    }
}
