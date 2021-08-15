import Foundation

class GameListViewModel: ObservableObject {
    @Published var games: [Game]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let gameService: GameAPIService
    
    init(gameService: GameAPIService = GameProcessor.shared) {
        self.gameService = gameService
    }
    
    func loadGames() {
        self.games = nil
        self.isLoading = true
        self.gameService.fetchGames { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.games = response.games
            case .failure(let error):
                self.error = error as NSError?
            }
        }
    }
}
