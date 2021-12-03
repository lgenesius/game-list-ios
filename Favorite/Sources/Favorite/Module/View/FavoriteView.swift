//
//  File.swift
//  
//
//  Created by Luis Genesius on 02/12/21.
//

import SwiftUI
import GamePackage

public struct FavoriteView<Destination: View>: View {
    @ObservedObject var presenter: FavoritePresenter
    public let destination: ((Int) -> Destination)
    
    public init(presenter: FavoritePresenter, destination: @escaping ((Int) -> Destination)) {
        self.presenter = presenter
        self.destination = destination
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    if !presenter.gameModels.isEmpty {
                        ForEach(presenter.gameModels) { game in
                            NavigationLink {
                                destination(game.id)
                            } label: {
                                CardView(game: game)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }

                        }
                    } else {
                        
                    }
                }
            }
            .navigationTitle(Text("Favorite"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            presenter.getGameEntities()
        })
        .onReceive(NotificationCenter.default.publisher(for: .refreshFavorite, object: nil), perform: { _ in
            presenter.getGameEntities()
        })
    }
}
