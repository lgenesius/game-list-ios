//
//  HomeInteractor.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Combine

/*
protocol HomeUseCase {
    
    func getGames() -> AnyPublisher<(String?, [GameModel]), Error>
    func searchGame(query: String) -> AnyPublisher<(String?, [GameModel]), Error>
    func nextGames(url: URL) -> AnyPublisher<(String?, [GameModel]), Error>
}

class HomeInteractor {
    
    private let repository: GameRemoteRepositoryProtocol
    
    required init(repository: GameRemoteRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeInteractor: HomeUseCase {
    
    func getGames() -> AnyPublisher<(String?, [GameModel]), Error> {
        return repository.getGames()
    }
    
    func searchGame(query: String) -> AnyPublisher<(String?, [GameModel]), Error> {
        return repository.searchGame(query: query)
    }
    
    func nextGames(url: URL) -> AnyPublisher<(String?, [GameModel]), Error> {
        return repository.nextGames(url: url)
    }
}
*/
