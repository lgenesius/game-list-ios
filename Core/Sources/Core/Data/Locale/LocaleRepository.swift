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
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func get(id: Int) -> AnyPublisher<Response?, Error>
    func add(entity: Response) -> AnyPublisher<Bool, Never>
    func delete(id: Int) -> AnyPublisher<Bool, Never>
}
