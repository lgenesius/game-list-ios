//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Combine

public protocol LocaleRepository {
    associatedtype Request
    associatedtype Response
    
    func list() -> AnyPublisher<[Response], Error>
    func get(id: Request) -> AnyPublisher<Response?, Error>
    func add(entity: Response) -> AnyPublisher<Bool, Never>
    func delete(id: Request) -> AnyPublisher<Bool, Never>
}
