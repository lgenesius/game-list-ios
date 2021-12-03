//
//  File.swift
//  
//
//  Created by Luis Genesius on 02/12/21.
//

import Foundation
import Combine

public protocol FavoriteUseCase {
    associatedtype Request
    associatedtype Response
    
    func getEntities(request: Request?) -> AnyPublisher<[Response], Error>
}
