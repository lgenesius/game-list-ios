import SwiftUI

struct FavoriteView: View {
    @StateObject var gameCoreDataViewModel = GameCoreDataViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack {
                        
                        if !gameCoreDataViewModel.savedEntities.isEmpty {
                            ForEach(gameCoreDataViewModel.savedEntities) { game in
                                NavigationLink(
                                    destination: EmptyView(),
                                    label: {
                                        CardView(game: Converter.fromGameEntityToGameRequest(game))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                    })
                            }
                        } else {
                            
                        }
                    }
                }
            }
            .navigationBarTitle("Favorite")
            .onReceive(NotificationCenter.default.publisher(for: .refreshFavorite, object: nil), perform: { _ in
                gameCoreDataViewModel.fetchGames()
            })
        }
    }
}
