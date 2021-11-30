//
//  File.swift
//  
//
//  Created by Luis Genesius on 29/11/21.
//

import Foundation
import Combine

public protocol HomeUseCase {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<(String?, [Response]), Error>
    func search(query: String) -> AnyPublisher<(String?, [Response]), Error>
    func next(url: URL) -> AnyPublisher<(String?, [Response]), Error>
}
