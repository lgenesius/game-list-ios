import Foundation

class GameListViewModel: ObservableObject {
    @Published var games: [Game]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let gameService: GameAPIService
    var nextPage: String?
    
    init(gameService: GameAPIService = GameProcessor.shared) {
        self.gameService = gameService
    }
    
    func loadFirstPageOfGames(completion: @escaping () -> Void) {
        self.games = nil
        self.isLoading = true
        self.gameService.fetchGames { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.nextPage = response.next
                self.games = response.games
                completion()
            case .failure(let error):
                self.error = error as NSError?
                completion()
            }
        }
    }
    
    func loadGameFromCoreData(games: [GameEntity]) {
        self.games = [Game]()
        guard !games.isEmpty else { return }
        self.isLoading = true
        for game in games {
            self.gameService.fetchGame(gameId: Int(game.id)) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let game):
                    print(game)
                    self.games?.append(game)
                case .failure(let error):
                    self.error = error as NSError
                }
            }
        }
        self.isLoading = false
    }
}
