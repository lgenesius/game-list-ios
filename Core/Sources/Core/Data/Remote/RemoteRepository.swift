//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Combine
import Foundation

public protocol RemoteRepository {
    associatedtype Request
    associatedtype Response
    associatedtype DetailResponse
    
    func list(request: Request?) -> AnyPublisher<(String?, [Response]), Error>
    func get(id: Int) -> AnyPublisher<DetailResponse, Error>
    func search(query: String) -> AnyPublisher<(String?, [Response]), Error>
    func next(url: URL) -> AnyPublisher<(String?, [Response]), Error>
}
