//
//  Injection.swift
//  Gameformation
//
//  Created by Luis Genesius on 19/11/21.
//

import Foundation
import Home
import Core
import GamePackage
import DetailGame
import Favorite

// swiftlint:disable all
final class Injection {
    
//    private func provideGameRemoteRepository() -> GameRemoteRepositoryProtocol {
//        let remote = GameRemoteDataSource.shared
//        return GameRemoteRepository.shared(remote)
//    }
//
//    private func provideGameLocalRepository() -> GameLocalRepositoryProtocol {
//        let local = GameLocalDataSource.shared
//        return GameLocalRepository.shared(local)
//    }
    
//    func provideHomeUseCase() -> HomeUseCase {
//        let repository = provideGameRemoteRepository()
//        return HomeInteractor(repository: repository)
//    }
    
//    func provideDetailUseCase(id: Int) -> DetailUseCase {
//        let remote = provideGameRemoteRepository()
//        let local = provideGameLocalRepository()
//        return DetailInteractor(id: id, remoteRepository: remote, localRepository: local)
//    }
//
//    func provideFavoriteUseCase() -> FavoriteUseCase {
//        let local = provideGameLocalRepository()
//        return FavoriteInteractor(localRepository: local)
//    }
    
    func provideHomeUseCase<U: HomeUseCase>() -> U where U.Request == Any, U.Response == GameModel {
        let remoteDataSource = GameRemoteDataSource()
        let remoteRepository = GameRemoteRepository(remoteDataSource: remoteDataSource)
        return HomeInteractor(repository: remoteRepository) as! U
    }
    
    func provideDetailUseCase<U: DetailUseCase>(id: Int) -> U where U.Request == GameModel, U.Response == DetailGameModel {
        let remoteDataSource = GameRemoteDataSource()
        let remoteRepository = GameRemoteRepository(remoteDataSource: remoteDataSource)
        
        let localeDataSource = GameLocalDataSource()
        let localeRepository = GameLocalRepository(localeDataSource: localeDataSource)
        
        return DetailInteractor(id: id, remoteRepository: remoteRepository, localRepository: localeRepository) as! U
    }
    
    func provideFavoriteUseCase<U: FavoriteUseCase>() -> U where U.Request == Any, U.Response == GameModel {
        let localeDataSource = GameLocalDataSource()
        let localeRepository = GameLocalRepository(localeDataSource: localeDataSource)
        return FavoriteInteractor(repository: localeRepository) as! U
    }
}
