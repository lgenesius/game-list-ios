//
//  File.swift
//  
//
//  Created by Luis Genesius on 02/12/21.
//

import SwiftUI
import Combine
import GamePackage

public class FavoritePresenter: ObservableObject {
    @Published var gameModels: [GameModel] = []
    
    private var cancelable: AnyCancellable?
    private let favoriteUseCase: FavoriteInteractor<Any, GameModel, GameLocalRepository<GameLocalDataSource>>
    
    public init(favoriteUseCase: FavoriteInteractor<Any, GameModel, GameLocalRepository<GameLocalDataSource>>) {
        self.favoriteUseCase = favoriteUseCase
        getGameEntities()
    }
    
    func getGameEntities() {
        cancelable?.cancel()
        cancelable = nil
        gameModels = []
        
        cancelable = favoriteUseCase.getEntities(request: nil)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] games in
                self?.gameModels = games
            })
    }
    
    deinit {
        cancelable?.cancel()
        cancelable = nil
    }
}
