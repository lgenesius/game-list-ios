//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation

struct GameAPI {
    
    static let baseURL = "https://api.rawg.io/api"
    static let key = "960c60d98d5b4e5abafd1878c7b83b37"
    
    enum Endpoint {
        case games
        case game(id: Int)
        case search(query: String)
        
        var urlString: String {
            switch self {
            case .games:
                return "\(GameAPI.baseURL)/games?key=\(GameAPI.key)"
            case .game(let id):
                return "\(GameAPI.baseURL)/games/\(id)?key=\(GameAPI.key)"
            case .search(let query):
                return "\(GameAPI.baseURL)/games?key=\(GameAPI.key)&search=\(query)"
            }
        }
    }
}
