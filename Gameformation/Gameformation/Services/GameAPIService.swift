import Foundation

protocol GameAPIService {
    func fetchGames(completion: @escaping (Result<GameResponse, APIError>) -> Void)
    func fetchGame(gameId: Int, completion: @escaping (Result<Game, APIError>) -> Void)
    func searchGame(query: String, completion: @escaping (Result<Game, APIError>) -> Void)
    func loadMoreGames(url: URL, completion: @escaping (Result<GameResponse, APIError>) -> Void)
}

enum APIError: Error, CustomNSError {
    case error
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    var localizedDescription: String {
        switch self {
        case .error: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
