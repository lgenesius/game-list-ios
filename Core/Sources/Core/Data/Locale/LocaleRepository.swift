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
    associatedtype DetailResponse
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func get(id: Int) -> AnyPublisher<DetailResponse?, Error>
    func add(entity: Response) -> AnyPublisher<Bool, Never>
    func delete(id: Int) -> AnyPublisher<Bool, Never>
}
