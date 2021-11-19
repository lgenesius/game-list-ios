//
//  HomePresenter.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private var cancelables: Set<AnyCancellable> = []
    private var token: AnyCancellable?
    
    private let router = TabRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var query = ""
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var nextPage: String?
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func beginProcess() {
        guard token == nil else { return }
        token = self.$query.map { [weak self] text in
            self?.games = []
            self?.error = nil
            return text
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
        .sink(receiveValue: { [weak self] in
            self?.search(query: $0)
        })
    }
    
    func search(query: String) {
        games = []
        isLoading = false
        error = nil
        
        guard !query.isEmpty  else {
            firstPageGames()
            return
        }
        
        isLoading = true
        homeUseCase.searchGame(query: query)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                    self?.error = nil
                case .failure(let error):
                    self?.error = error as NSError?
                }
            } receiveValue: { [weak self] values in
                self?.nextPage = values.0
                self?.games = values.1
            }
            .store(in: &cancelables)
    }
    
    private func firstPageGames() {
        isLoading = true
        homeUseCase.getGames()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                    self?.error = nil
                case .failure(let error):
                    self?.error = error as NSError?
                }
            } receiveValue: { [weak self] values in
                self?.nextPage = values.0
                self?.games = values.1
            }
            .store(in: &cancelables)
    }
    
    func loadNextGames(game: Game) {
        guard let lastGame = games.last, game.id == lastGame.id, let nextURL = nextGamesURL() else { return }
        isLoading = true
        homeUseCase.nextGames(url: nextURL)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                    self?.error = nil
                case .failure(let error):
                    self?.error = error as NSError?
                }
            } receiveValue: { [weak self] values in
                self?.nextPage = values.0
                self?.games += values.1
            }
            .store(in: &cancelables)
    }
    
    private func nextGamesURL() -> URL? {
        guard let nextString = self.nextPage else { return nil }
        guard let url = URL(string: nextString) else { return nil }
        return url
    }
    
    func linkBuilder<Content: View>(with id: Int, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.createDetailView(from: .home, with: id)) { content() }
    }
    
    deinit {
        self.cancelables.removeAll()
        self.token?.cancel()
        self.token = nil
    }
}
