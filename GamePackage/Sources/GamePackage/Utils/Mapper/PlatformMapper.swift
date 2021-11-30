//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

public struct PlatformMapper {
    
    public static func mapPlatformToPlatformModel(_ platforms: [Platform]) -> [PlatformModel] {
        return platforms.map { result in
            return PlatformModel(
                id: result.platform.id,
                name: result.platform.name
            )
        }
    }
}
