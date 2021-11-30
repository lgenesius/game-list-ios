//
//  File.swift
//  
//
//  Created by Luis Genesius on 29/11/21.
//

import Foundation
import SwiftUI
import Core
import GamePackage

public struct HomeView<Destination: View>: View {
    @ObservedObject var presenter: HomePresenter
    public let destination: (() -> Destination)
    
    public init(presenter: HomePresenter, destination: @escaping (() -> Destination)) {
        self.presenter = presenter
        self.destination = destination
    }
    
    public var body: some View {
        NavigationView {
                ScrollView {
                    LazyVStack {
                        
                        SearchBar(placeholder: "Search any games...", text: self.$presenter.query)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        if let gameResults = presenter.games {
                            ForEach(gameResults) { game in
                                NavigationLink {
                                    destination()
                                } label: {
                                    CardView(game: game)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .onAppear {
                                            guard let lastGame = presenter.games.last, game.id == lastGame.id, let nextURL = presenter.nextGamesURL() else { return }
                                            presenter.loadNextGames(nextURL: nextURL)
                                        }
                                }

                            }
                        }
                        
                        ActivityIndicatorView(isLoading: presenter.isLoading, error: presenter.error) {
                            presenter.search(query: presenter.query)
                        }
                    }
                }
            .navigationTitle(Text("Gameformation"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            presenter.beginProcess()
        }
    }
}
