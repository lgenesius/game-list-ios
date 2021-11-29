//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Combine
import Foundation

public protocol RemoteDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<(String?, [Response]), Error>
    func get(id: Int) -> AnyPublisher<Response, Error>
    func search(query: String) -> AnyPublisher<(String?, [Response]), Error>
    func next(url: URL) -> AnyPublisher<(String?, [Response]), Error>
}
