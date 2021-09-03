import SwiftUI

struct HomeView: View {
    
    @StateObject var gameSearchViewModel = GameSearchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack {
                        
                        SearchBarView(placeholder: "Search any games...", text: self.$gameSearchViewModel.query)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        if let gameResults = gameSearchViewModel.games {
                            ForEach(gameResults) { game in
                                NavigationLink(
                                    destination: DetailView(gameId: game.id, previous: "Gameformation"),
                                    label: {
                                        CardView(name: game.name, released: game.released, overallRating: game.overallRating, backgroundImage: game.backgroundImage)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .onAppear {
                                                gameSearchViewModel.loadNextPage(game: game)
                                            }
                                    })
                            }
                        }
                        
                        ActivityIndicatorView(isLoading: self.gameSearchViewModel.isLoading, error: self.gameSearchViewModel.error) {
                            self.gameSearchViewModel.search(query: self.gameSearchViewModel.query)
                        }
                    }
                }
            }
            .navigationBarTitle("Gameformation")
        }
        .onAppear {
            gameSearchViewModel.beginProcess()
        }
    }
}
