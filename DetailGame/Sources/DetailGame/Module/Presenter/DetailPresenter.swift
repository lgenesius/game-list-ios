//
//  File.swift
//  
//
//  Created by Luis Genesius on 01/12/21.
//

import Foundation
import Combine
import GamePackage

public enum ParentView {
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

public class DetailPresenter: ObservableObject {
    @Published var game: DetailGameModel?
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var isFavorited = false
    
    private let detailUseCase: DetailInteractor<GameModel, DetailGameModel, GameRemoteRepository<GameRemoteDataSource>, GameLocalRepository<GameLocalDataSource>>
    private let parentView: ParentView
    
    private var cancelables: Set<AnyCancellable> = []
    
    public init(parentView: ParentView, detailUseCase: DetailInteractor<GameModel, DetailGameModel, GameRemoteRepository<GameRemoteDataSource>, GameLocalRepository<GameLocalDataSource>>) {
        self.detailUseCase = detailUseCase
        self.parentView = parentView
    }
    
    func getGame() {
        game = nil
        error = nil
        
        isLoading = true
        detailUseCase.getResponse()
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
        detailUseCase.getEntity()
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
        return parentView == .home ? (isFavorited ? "favorited": "favorite"): "unfavorite"
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
            let request = GameModel(id: game.id, name: game.name, released: game.released, backgroundImage: game.backgroundImage, overallRating: game.overallRating)
            detailUseCase.add(request: request)
                .receive(on: RunLoop.main)
                .sink { [weak self] status in
                    if status {
                        self?.getGame()
                        self?.isFavorited = true
//                        NotificationCenter.default.post(name: .refreshFavorite, object: nil)
                    }
                }
                .store(in: &cancelables)
        }
    }
    
    private func favoriteTrailingToolbarAction() {
        detailUseCase.delete()
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
