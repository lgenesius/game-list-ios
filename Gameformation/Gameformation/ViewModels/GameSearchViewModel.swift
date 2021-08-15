import SwiftUI
import Combine
import Foundation

class GameSearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var games: [Game]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var token: AnyCancellable?
    
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
            return
        }
        
        self.isLoading = true
        self.gameService.searchGame(query: query) { [weak self] (result) in
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
    
    deinit {
        self.token?.cancel()
        self.token = nil
    }
}
