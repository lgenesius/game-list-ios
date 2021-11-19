//
//  Injection.swift
//  Gameformation
//
//  Created by Luis Genesius on 19/11/21.
//

import Foundation

final class Injection {
    
    private func provideGameRemoteRepository() -> GameRemoteRepositoryProtocol {
        let remote = GameRemoteDataSource.shared
        return GameRemoteRepository.shared(remote)
    }
    
    func provideHomeUseCase() -> HomeUseCase {
        let repository = provideGameRemoteRepository()
        return HomeInteractor(repository: repository)
    }
}
