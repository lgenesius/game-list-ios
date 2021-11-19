import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack {
                        
                        SearchBarView(placeholder: "Search any games...", text: self.$presenter.query)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        if let gameResults = presenter.games {
                            ForEach(gameResults) { game in
                                presenter.linkBuilder(with: game.id) {
                                    CardView(game: Converter.fromGameToGameRequest(game))
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
            }
            .navigationBarTitle("Gameformation")
        }
        .onAppear {
            presenter.beginProcess()
        }
    }
}
