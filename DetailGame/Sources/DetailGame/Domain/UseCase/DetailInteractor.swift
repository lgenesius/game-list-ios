//
//  File.swift
//  
//
//  Created by Luis Genesius on 01/12/21.
//

import Foundation
import Core
import Combine
import GamePackage

// Request = GameModel, Response = DetailGameModel
public struct DetailInteractor<Request, Response, R: RemoteRepository, L:LocaleRepository>: DetailUseCase where R.Request == Any, R.Response == Request, R.DetailResponse == Response, L.Request == Any, L.Response == Request, L.DetailResponse == Response {
    private let id: Int
    private let _remoteRepo: R
    private let _localRepo: L
    
    public init(id: Int, remoteRepository: R, localRepository: L) {
        self.id = id
        self._remoteRepo = remoteRepository
        self._localRepo = localRepository
    }
    
    public func getResponse() -> AnyPublisher<Response, Error> {
        return _remoteRepo.get(id: id)
    }
    
    public func getEntity() -> AnyPublisher<Response?, Error> {
        return _localRepo.get(id: id)
    }
    
    public func add(request: Request) -> AnyPublisher<Bool, Never> {
        return _localRepo.add(entity: request)
    }
    
    public func delete() -> AnyPublisher<Bool, Never> {
        return _localRepo.delete(id: id)
    }
}
