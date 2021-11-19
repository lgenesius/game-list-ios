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
    private var cancelable: AnyCancellable?
    
    init(detailUseCase: DetailUseCase, parentView: ParentView) {
        self.detailUseCase = detailUseCase
        self.parentView = parentView
    }
    
    func getGame() {
        game = nil
        error = nil
        cancelable?.cancel()
        cancelable = nil
        
        isLoading = true
        cancelable = detailUseCase.getGame()
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
    }
    
    deinit {
        cancelable?.cancel()
        cancelable = nil
    }
}
