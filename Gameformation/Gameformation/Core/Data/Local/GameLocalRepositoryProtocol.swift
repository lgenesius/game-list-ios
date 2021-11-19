//
//  GameLocalRepositoryProtocol.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Combine

protocol GameLocalRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func getGame(with id: Int) -> AnyPublisher<GameEntity?, Error>
    func addGame(request game: GameRequest) -> AnyPublisher<Bool, Never>
    func deleteGame(game: GameEntity) -> AnyPublisher<Bool, Never>
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
    
    func getGames() -> AnyPublisher<[GameEntity], Error> {
        local.getGames()
    }
    
    func getGame(with id: Int) -> AnyPublisher<GameEntity?, Error> {
        local.getGame(with: id)
    }
    
    func addGame(request game: GameRequest) -> AnyPublisher<Bool, Never> {
        local.addGame(request: game)
    }
    
    func deleteGame(game: GameEntity) -> AnyPublisher<Bool, Never> {
        local.deleteGame(game: game)
    }
}
