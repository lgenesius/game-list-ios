import Foundation

class DetailGameViewModel: ObservableObject {
    @Published var game: Game?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let gameService: GameAPIService
    
    init(gameService: GameAPIService = GameProcessor.shared) {
        self.gameService = gameService
    }
    
    func loadGame(id: Int) {
        self.game = nil
        self.isLoading = true
        self.gameService.fetchGame(gameId: id) { [weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let game):
                self.game = game
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
