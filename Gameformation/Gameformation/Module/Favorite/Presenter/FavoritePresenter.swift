//
//  FavoritePresenter.swift
//  Gameformation
//
//  Created by Luis Genesius on 20/11/21.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    @Published var gameModels: [GameModel] = []
    
    private let router = TabRouter()
    private var cancelable: AnyCancellable?
    private let favoriteUseCase: FavoriteUseCase
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
        getGameEntities()
    }
    
    func getGameEntities() {
        cancelable?.cancel()
        cancelable = nil
        gameModels = []
        
        cancelable = favoriteUseCase.getGameEntities()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] games in
                self?.gameModels = games
            })
    }
    
    func linkBuilder<Content: View>(with id: Int, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.createDetailView(from: .favorite, with: id)) { content() }
    }
    
    deinit {
        cancelable?.cancel()
        cancelable = nil
    }
}
