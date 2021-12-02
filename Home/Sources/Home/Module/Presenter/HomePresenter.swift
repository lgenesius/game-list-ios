//
//  File.swift
//  
//
//  Created by Luis Genesius on 29/11/21.
//

import Foundation
import Combine
import GamePackage

public class HomePresenter: ObservableObject {
    
    private var cancelables: Set<AnyCancellable> = []
    private var token: AnyCancellable?
    
    private let homeUseCase: HomeInteractor<Any, GameModel, GameRemoteRepository<GameRemoteDataSource>>
    
    @Published var query = ""
    @Published var games: [GameModel] = []
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var nextPage: String?
    
    public init(homeUseCase: HomeInteractor<Any, GameModel, GameRemoteRepository<GameRemoteDataSource>>) {
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
        homeUseCase.search(query: query)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
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
        homeUseCase.list(request: nil)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
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
    
    func loadNextGames(nextURL: URL) {
        isLoading = true
        homeUseCase.next(url: nextURL)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
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
    
    func nextGamesURL() -> URL? {
        guard let nextString = self.nextPage else { return nil }
        guard let url = URL(string: nextString) else { return nil }
        return url
    }
    
    deinit {
        self.cancelables.removeAll()
        self.token?.cancel()
        self.token = nil
    }
}
