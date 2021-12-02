//
//  File.swift
//  
//
//  Created by Luis Genesius on 29/11/21.
//

import Foundation
import Core
import Combine
import GamePackage

public struct HomeInteractor<Request, Response, R: RemoteRepository>: HomeUseCase where R.Request == Request, R.Response == Response, R.DetailResponse == DetailGameModel  {
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func list(request: Request?) -> AnyPublisher<(String?, [Response]), Error> {
        return _repository.list(request: request)
    }
    
    public func search(query: String) -> AnyPublisher<(String?, [Response]), Error> {
        return _repository.search(query: query)
    }
    
    public func next(url: URL) -> AnyPublisher<(String?, [Response]), Error> {
        return _repository.next(url: url)
    }
}
