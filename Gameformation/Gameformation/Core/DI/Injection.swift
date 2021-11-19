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
    
    private func provideGameLocalRepository() -> GameLocalRepositoryProtocol {
        let local = GameLocalDataSource.shared
        return GameLocalRepository.shared(local)
    }
    
    func provideHomeUseCase() -> HomeUseCase {
        let repository = provideGameRemoteRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetailUseCase(id: Int) -> DetailUseCase {
        let remote = provideGameRemoteRepository()
        let local = provideGameLocalRepository()
        return DetailInteractor(id: id, remoteRepository: remote, localRepository: local)
    }
}
