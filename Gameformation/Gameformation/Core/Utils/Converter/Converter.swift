//
//  Mapper.swift
//  Gameformation
//
//  Created by Luis Genesius on 19/11/21.
//

import Foundation

// swiftlint:disable all
final class Converter {
    
    static func fromGameToDetailGameModel(_ game: Game) -> DetailGameModel {
        return DetailGameModel(
            id: game.id,
            name: game.name,
            released: game.released,
            backgroundImage: game.backgroundImage,
            overallRating: game.overallRating,
            platforms: PlatformMapper.mapPlatformsToPlatformModels(input: game.platforms ?? []),
            publishers: PublisherMapper.mapPublishersToPublisherModels(input: game.publishers ?? []),
            gameDescription: game.gameDescription)
    }
    
    static func fromGameEntitytoDetailGameModel(_ game: GameEntity?) -> DetailGameModel? {
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
