//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Foundation

public protocol Converter {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func convertResponseToDomain(response: Response) -> Domain
    func convertEntityToDomain(entity: Entity?) -> Domain?
}
