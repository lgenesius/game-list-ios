//
//  HomeInteractor.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Combine

protocol HomeUseCase {
    
    func getGames() -> AnyPublisher<[Game], Error>
    func getGame(id: Int) -> AnyPublisher<Game, Error>
    func searchGame(query: String) -> AnyPublisher<[Game], Error>
    func nextGames(url: URL) -> AnyPublisher<[Game], Error>
}

class HomeInteractor {
    
    private let repository: GameRemoteRepositoryProtocol
    
    required init(repository: GameRemoteRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeInteractor: HomeUseCase {
    
    func getGames() -> AnyPublisher<[Game], Error> {
        return repository.getGames()
    }
    
    func getGame(id: Int) -> AnyPublisher<Game, Error> {
        return repository.getGame(id: id)
    }
    
    func searchGame(query: String) -> AnyPublisher<[Game], Error> {
        return repository.searchGame(query: query)
    }
    
    func nextGames(url: URL) -> AnyPublisher<[Game], Error> {
        return repository.nextGames(url: url)
    }
}
