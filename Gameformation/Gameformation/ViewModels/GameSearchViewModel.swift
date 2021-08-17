import SwiftUI
import Combine

class GameSearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var games: [Game]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var token: AnyCancellable?
    
    var gameResponse: GameResponse?
    var nextPage: String?
    let gameService: GameAPIService
    
    init(gameService: GameAPIService = GameProcessor.shared) {
        self.gameService = gameService
    }
    
    func beginProcess() {
        guard token == nil else { return }
        self.token = self.$query.map { [weak self] text in
            self?.games = nil
            self?.error = nil
            return text
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
        .sink(receiveValue: { [weak self] in
            self?.search(query: $0)
        })
    }
    
    func search(query: String) {
        self.games = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty  else {
            initFirstPageOfGames()
            return
        }
        
        self.isLoading = true
        self.gameService.searchGame(query: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.nextPage = response.next
                self.games = response.games
            case .failure(let error):
                self.error = error as NSError?
            }
        }
    }
    
    func loadNextPage(game: Game) {
        guard let games = self.games else { return }
        guard let lastGame = games.last else { return }
        guard game.id == lastGame.id else { return }
        guard let nextURL = nextPageURL() else { return }
        
        self.isLoading = true
        self.gameService.loadMoreGames(url: nextURL) { [weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.successLoadNextPage(response: response)
            case .failure(let error):
                self.error = error as NSError?
            }
        }
    }
    
    private func successLoadNextPage(response: GameResponse) {
        self.nextPage = response.next
        self.games? += response.games
    }
    
    private func nextPageURL() -> URL? {
        guard let nextString = self.nextPage else { return nil }
        guard let url = URL(string: nextString) else { return nil }
        return url
    }
    
    private func initFirstPageOfGames() {
        self.isLoading = true
        let gamelistVM = GameListViewModel()
        gamelistVM.loadFirstPageOfGames {
            self.nextPage = gamelistVM.nextPage
            self.games = gamelistVM.games
            self.isLoading = false
            self.error = gamelistVM.error
        }
    }
    
    deinit {
        self.token?.cancel()
        self.token = nil
    }
}
