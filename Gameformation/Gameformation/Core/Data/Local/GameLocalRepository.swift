//
//  GameLocalRepositoryProtocol.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Combine

/*
protocol GameLocalRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[GameModel], Error>
    func getGame(with id: Int) -> AnyPublisher<DetailGameModel?, Error>
    func addGame(request game: GameModel) -> AnyPublisher<Bool, Never>
    func deleteGame(id: Int) -> AnyPublisher<Bool, Never>
}

final class GameLocalRepository {
    
    private let local: GameLocalDataSource
    
    private init(local: GameLocalDataSource) {
        self.local = local
    }
    
    static let shared: (GameLocalDataSource) -> GameLocalRepository = { local in
        return GameLocalRepository(local: local)
    }
}

extension GameLocalRepository: GameLocalRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return local.getGames()
            .map { GameMapper.mapGameEntitiesToGameModels(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getGame(with id: Int) -> AnyPublisher<DetailGameModel?, Error> {
        return local.getGame(with: id)
            .map { Converter.fromGameEntitytoDetailGameModel($0) }
            .eraseToAnyPublisher()
    }
    
    func addGame(request game: GameModel) -> AnyPublisher<Bool, Never> {
        local.addGame(id: game.id, name: game.name, released: game.released, overallRating: game.overallRating, backgroundImage: game.backgroundImage)
    }
    
    func deleteGame(id: Int) -> AnyPublisher<Bool, Never> {
        local.deleteGame(id: id)
    }
}
*/
