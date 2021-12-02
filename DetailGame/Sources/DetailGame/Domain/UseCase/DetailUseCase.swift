//
//  File.swift
//  
//
//  Created by Luis Genesius on 01/12/21.
//

import Foundation
import Combine

public protocol DetailUseCase {
    associatedtype Request
    associatedtype Response
    
    func getResponse() -> AnyPublisher<Response, Error>
    func getEntity() -> AnyPublisher<Response?, Error>
    func add(request: Request) -> AnyPublisher<Bool, Never>
    func delete() -> AnyPublisher<Bool, Never>
}
