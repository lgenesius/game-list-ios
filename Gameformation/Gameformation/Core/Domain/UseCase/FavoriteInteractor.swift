//
//  FavoriteInteractor.swift
//  Gameformation
//
//  Created by Luis Genesius on 20/11/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getGameEntities() -> AnyPublisher<[GameEntity], Error>
}

class FavoriteInteractor {
    
    private let localRepository: GameLocalRepositoryProtocol
    
    required init(localRepository: GameLocalRepositoryProtocol) {
        self.localRepository = localRepository
    }
}

extension FavoriteInteractor: FavoriteUseCase {
    
    func getGameEntities() -> AnyPublisher<[GameEntity], Error> {
        localRepository.getGames()
    }
}
