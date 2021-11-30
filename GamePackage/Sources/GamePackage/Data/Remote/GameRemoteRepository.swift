//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation
import Combine
import Core

public struct GameRemoteRepository<
    GameRemoteDS: RemoteDataSource>: RemoteRepository
where GameRemoteDS.Response == Game {
    public typealias Request = Any
    public typealias Response = GameModel
    public typealias DetailResponse = DetailGameModel
    
    private let _remoteDataSource: GameRemoteDS
    
    public init(remoteDataSource: GameRemoteDS) {
        self._remoteDataSource = remoteDataSource
    }
    
    public func list(request: Any?) -> AnyPublisher<(String?, [GameModel]), Error> {
        return _remoteDataSource.list(request: nil)
            .map { ($0.0, GameMapper.mapGameToGameModel($0.1)) }
            .eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<DetailGameModel, Error> {
        return _remoteDataSource.get(id: id)
            .map { GameConverter.convertGameToDetailGameModel($0) }
            .eraseToAnyPublisher()
    }
    
    public func search(query: String) -> AnyPublisher<(String?, [GameModel]), Error> {
        return _remoteDataSource.search(query: query)
            .map { ($0.0, GameMapper.mapGameToGameModel($0.1)) }
            .eraseToAnyPublisher()
    }
    
    public func next(url: URL) -> AnyPublisher<(String?, [GameModel]), Error> {
        return _remoteDataSource.next(url: url)
            .map { ($0.0, GameMapper.mapGameToGameModel($0.1)) }
            .eraseToAnyPublisher()
    }
}
