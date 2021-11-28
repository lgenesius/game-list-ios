import SwiftUI
import Common

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationView {
                ScrollView {
                    LazyVStack {
                        
                        SearchBarView(placeholder: "Search any games...", text: self.$presenter.query)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        if let gameResults = presenter.games {
                            ForEach(gameResults) { game in
                                presenter.linkBuilder(with: game.id) {
                                    CardView(game: game)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .onAppear {
                                            presenter.loadNextGames(game: game)
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
