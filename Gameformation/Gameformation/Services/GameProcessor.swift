import Foundation

class GameProcessor: GameAPIService {
    static let shared = GameProcessor()
    
    private var key: String {
        /* code below here is to get value from info.plist
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
         */
        
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        
        return apiKey
    }
    
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
        self.loadURLAndDecodeWithoutParam(url: url, completion: completion)
    }
    
    func loadURLAndDecodeWithoutParam<C: Codable>(url: URL, completion: @escaping (Result<C, APIError>) -> Void) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
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
                self.executeInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
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
                self.executeInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeInMainThread<C: Codable>(with result: Result<C, APIError>, completion: @escaping (Result<C, APIError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
