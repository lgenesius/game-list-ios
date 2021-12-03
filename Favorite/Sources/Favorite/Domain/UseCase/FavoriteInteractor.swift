//
//  File.swift
//  
//
//  Created by Luis Genesius on 02/12/21.
//

import Foundation
import Core
import Combine
import GamePackage

public struct FavoriteInteractor<Request, Response, L: LocaleRepository>: FavoriteUseCase where L.Request == Request, L.Response == Response {
    private let _repository: L
    
    public init(repository: L) {
        self._repository = repository
    }
    
    public func getEntities(request: Request?) -> AnyPublisher<[Response], Error> {
        _repository.list(request: nil)
    }
}
