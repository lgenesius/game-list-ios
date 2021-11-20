import SwiftUI

struct FavoriteView: View {
    @StateObject var gameCoreDataViewModel = GameCoreDataViewModel()
    
    var body: some View {
        NavigationView {
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
            .navigationTitle(Text("Favorite"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(NotificationCenter.default.publisher(for: .refreshFavorite, object: nil), perform: { _ in
            gameCoreDataViewModel.fetchGames()
        })
    }
}
