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
