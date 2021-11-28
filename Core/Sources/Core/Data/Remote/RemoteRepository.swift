//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Combine

public protocol RemoteRepository {
    associatedtype Request
    associatedtype Response
    
    func list() -> AnyPublisher<[Response], Error>
    func get(id: Request) -> AnyPublisher<Response, Error>
    func search(query: Request) -> AnyPublisher<[Response], Error>
    func next(url: Request) -> AnyPublisher<[Response], Error>
}
