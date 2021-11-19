//
//  Mapper.swift
//  Gameformation
//
//  Created by Luis Genesius on 19/11/21.
//

import Foundation

// swiftlint:disable all
final class Converter {
    
    static func fromGameEntityToGame(_ game: GameEntity) -> Game {
        return Game(id: Int(game.id), name: game.name!, released: game.released!, backgroundImage: game.backgroundImage!, overallRating: game.overallRating, platforms: nil, publishers: nil, gameDescription: nil)
    }
}
