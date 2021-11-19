//
//  GameRepository.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Combine

protocol GameRemoteRepositoryProtocol {
    
    func getGames() -> AnyPublisher<(String?, [Game]), Error>
    func getGame(id: Int) -> AnyPublisher<Game, Error>
    func searchGame(query: String) -> AnyPublisher<(String?, [Game]), Error>
    func nextGames(url: URL) -> AnyPublisher<(String?, [Game]), Error>
}

final class GameRemoteRepository {
    
    private let remote: GameRemoteDataSource
    
    private init(remote: GameRemoteDataSource) {
        self.remote = remote
    }
    
    static let shared: (GameRemoteDataSource) -> GameRemoteRepository = { remote in
        return GameRemoteRepository(remote: remote)
    }
}

extension GameRemoteRepository: GameRemoteRepositoryProtocol {
    
    func getGames() -> AnyPublisher<(String?, [Game]), Error> {
        return remote.getGames()
            .map { ($0.next, $0.games) }
            .eraseToAnyPublisher()
    }
    
    func getGame(id: Int) -> AnyPublisher<Game, Error> {
        return remote.getGame(id: id)
    }
    
    func searchGame(query: String) -> AnyPublisher<(String?, [Game]), Error> {
        return remote.searchGame(query: query)
            .map { ($0.next, $0.games) }
            .eraseToAnyPublisher()
    }
    
    func nextGames(url: URL) -> AnyPublisher<(String?, [Game]), Error> {
        return remote.nextGames(url: url)
            .map { ($0.next, $0.games) }
            .eraseToAnyPublisher()
    }
    
}
