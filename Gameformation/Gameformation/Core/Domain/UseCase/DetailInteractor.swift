//
//  DetailInteractor.swift
//  Gameformation
//
//  Created by Luis Genesius on 19/11/21.
//

import Foundation
import Combine

/*
protocol DetailUseCase {
    
    func getGame() -> AnyPublisher<DetailGameModel, Error>
    func getGameEntity() -> AnyPublisher<DetailGameModel?, Error>
    func addGame(request game: GameModel) -> AnyPublisher<Bool, Never>
    func deleteGame() -> AnyPublisher<Bool, Never>
}

class DetailInteractor {
    private let id: Int
    private let remoteRepository: GameRemoteRepositoryProtocol
    private let localRepository: GameLocalRepositoryProtocol
    
    required init(id: Int, remoteRepository: GameRemoteRepositoryProtocol, localRepository: GameLocalRepositoryProtocol) {
        self.id = id
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension DetailInteractor: DetailUseCase {
    
    func getGame() -> AnyPublisher<DetailGameModel, Error> {
        remoteRepository.getGame(id: id)
    }
    
    func getGameEntity() -> AnyPublisher<DetailGameModel?, Error> {
        localRepository.getGame(with: id)
    }
    
    func addGame(request game: GameModel) -> AnyPublisher<Bool, Never> {
        localRepository.addGame(request: game)
    }
    
    func deleteGame() -> AnyPublisher<Bool, Never> {
        localRepository.deleteGame(id: id)
    }
}
*/
