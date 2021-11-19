//
//  DetailPresenter.swift
//  Gameformation
//
//  Created by Luis Genesius on 19/11/21.
//

import SwiftUI
import Combine

enum ParentView {
    case home
    case favorite
    
    var title: String {
        switch self {
        case .home:
            return "Gameformation"
        case .favorite:
            return "Favorite"
        }
    }
}

class DetailPresenter: ObservableObject {
    @Published var game: Game?
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var isFavorited = false
    
    private let detailUseCase: DetailUseCase
    private let parentView: ParentView
    private var cancelables: Set<AnyCancellable> = []
    
    init(detailUseCase: DetailUseCase, parentView: ParentView) {
        self.detailUseCase = detailUseCase
        self.parentView = parentView
    }
    
    func getGame() {
        game = nil
        error = nil
        
        isLoading = true
        detailUseCase.getGame()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.error = error as NSError?
                }
            } receiveValue: { [weak self] game in
                self?.game = game
            }
            .store(in: &cancelables)
    }
    
    func setFavoriteStatus() {
        detailUseCase.getGameEntity()
            .receive(on: RunLoop.main)
            .sink { _ in
                
            } receiveValue: { [weak self] gameEntity in
                self?.isFavorited = gameEntity == nil ? false: true
            }
            .store(in: &cancelables)
    }
    
    func disableToolbar() -> Bool {
        return parentView == .home && isFavorited
    }
    
    func setTrailingToolbarText() -> String {
        return parentView == .home ? (isFavorited ? "Favorited": "Favorite"): "Unfavorite"
    }
    
    func trailingToolbarAction() {
        if parentView == .home {
            homeTrailingToolbarAction()
        } else {
            favoriteTrailingToolbarAction()
        }
    }
    
    private func homeTrailingToolbarAction() {
        guard let game = game else { return }
        
        if !isFavorited {
            let gameRequest = GameRequest(id: game.id, name: game.name, released: game.released, backgroundImage: game.backgroundImage, overallRating: game.overallRating)
            detailUseCase.addGame(request: gameRequest)
                .receive(on: RunLoop.main)
                .sink { [weak self] status in
                    if status {
                        self?.getGame()
                        self?.isFavorited = true
                        NotificationCenter.default.post(name: .refreshFavorite, object: nil)
                    }
                }
                .store(in: &cancelables)
        }
    }
    
    private func favoriteTrailingToolbarAction() {
        detailUseCase.getGameEntity()
            .receive(on: RunLoop.main)
            .sink { _ in
                
            } receiveValue: { [weak self] gameEntity in
                if let entity = gameEntity {
                    self?.deleteGameEntity(entity: entity)
                }
            }
            .store(in: &cancelables)
    }
    
    private func deleteGameEntity(entity: GameEntity) {
        detailUseCase.deleteGame(game: entity)
            .receive(on: RunLoop.main)
            .sink { status in
                if status {
                    NotificationCenter.default.post(name: .refreshFavorite, object: nil)
                }
            }
            .store(in: &cancelables)
    }
    
    deinit {
        cancelables.removeAll()
    }
}
