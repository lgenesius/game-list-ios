import Foundation

class GameProcessor: GameAPIService {
    static let shared = GameProcessor()
    private let key = "960c60d98d5b4e5abafd1878c7b83b37"
    private let baseURL = "https://api.rawg.io/api"
    private let urlSession = URLSession.shared
    
    private init() {}
    
    func fetchGames(completion: @escaping (Result<GameResponse, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/games") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchGame(gameId: Int, completion: @escaping (Result<Game, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/games/\(gameId)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func searchGame(query: String, completion: @escaping (Result<GameResponse, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/games") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["search": query], completion: completion)
    }
    
    func loadMoreGames(url: URL, completion: @escaping (Result<GameResponse, APIError>) -> Void) {
        
    }
    
    func loadURLAndDecode<C: Codable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<C, APIError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "key", value: key)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        print(queryItems)
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                self.executeInMainThread(with: .failure(.error), completion: completion)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(C.self, from: data)
                self.executeInMainThread(with: .success(decoded), completion: completion)
            } catch {
                debugPrint(error)
                self.executeInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeInMainThread<C: Decodable>(with result: Result<C, APIError>, completion: @escaping (Result<C, APIError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
