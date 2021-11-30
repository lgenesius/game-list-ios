//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

public struct PublisherMapper {
    
    public static func mapPublisherToPublisherModel(_ publishers: [Publisher]) -> [PublisherModel] {
        return publishers.map { result in
            return PublisherModel(
                id: result.id,
                name: result.name,
                imageBackground: result.imageBackground
            )
        }
    }
}
