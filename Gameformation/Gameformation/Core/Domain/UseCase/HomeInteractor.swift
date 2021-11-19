//
//  HomeInteractor.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Combine

protocol HomeUseCase {
    
    func getGames() -> AnyPublisher<(String?, [Game]), Error>
    func searchGame(query: String) -> AnyPublisher<(String?, [Game]), Error>
    func nextGames(url: URL) -> AnyPublisher<(String?, [Game]), Error>
}

class HomeInteractor {
    
    private let repository: GameRemoteRepositoryProtocol
    
    required init(repository: GameRemoteRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeInteractor: HomeUseCase {
    
    func getGames() -> AnyPublisher<(String?, [Game]), Error> {
        return repository.getGames()
    }
    
    func searchGame(query: String) -> AnyPublisher<(String?, [Game]), Error> {
        return repository.searchGame(query: query)
    }
    
    func nextGames(url: URL) -> AnyPublisher<(String?, [Game]), Error> {
        return repository.nextGames(url: url)
    }
}
