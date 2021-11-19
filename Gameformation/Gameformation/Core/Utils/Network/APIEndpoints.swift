//
//  APIEndpoints.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation

struct API {
    
    static let baseURL = "https://api.rawg.io/api"
    static var key: String {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return apiKey
    }
    
    enum Endpoint {
        case games
        case game(id: Int)
        case search(query: String)
        
        var urlString: String {
            switch self {
            case .games:
                return "\(API.baseURL)/games?key=\(API.key)"
            case .game(let id):
                return "\(API.baseURL)/games/\(id)?key=\(API.key)"
            case .search(let query):
                return "\(API.baseURL)/games?key=\(API.key)&search=\(query)"
            }
        }
    }
}
