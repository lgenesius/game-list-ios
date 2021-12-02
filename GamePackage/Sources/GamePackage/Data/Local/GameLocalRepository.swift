//
//  File.swift
//  
//
//  Created by Luis Genesius on 01/12/21.
//

import Foundation
import Core
import CoreData
import Combine

public struct GameLocalRepository<GameLocalDS: LocaleDataSource>: LocaleRepository where GameLocalDS.Response == GameEntity {
    public typealias Request = Any
    public typealias Response = GameModel
    public typealias DetailResponse = DetailGameModel
    
    private let _localeDataSource: GameLocalDS
    
    public init(localeDataSource: GameLocalDS) {
        self._localeDataSource = localeDataSource
    }
    
    public func list(request: Any?) -> AnyPublisher<[GameModel], Error> {
        return _localeDataSource.list(request: nil)
            .map { GameMapper.mapGameEntityToGameModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<DetailGameModel?, Error> {
        return _localeDataSource.get(id: id)
            .map { GameConverter.fromGameEntitytoDetailGameModel($0) }
            .eraseToAnyPublisher()
    }
    
    public func add(entity: GameModel) -> AnyPublisher<Bool, Never> {
        _localeDataSource.add(id: entity.id, name: entity.name, released: entity.released, overallRating: entity.overallRating, backgroundImage: entity.backgroundImage)
    }
    
    public func delete(id: Int) -> AnyPublisher<Bool, Never> {
        _localeDataSource.delete(id: id)
    }
}
