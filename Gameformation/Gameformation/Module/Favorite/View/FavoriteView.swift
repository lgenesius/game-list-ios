import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    if !presenter.gameEntities.isEmpty {
                        ForEach(presenter.gameEntities) { game in
                            presenter.linkBuilder(with: Int(game.id)) {
                                CardView(game: Converter.fromGameEntityToGameRequest(game))
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
        .onReceive(NotificationCenter.default.publisher(for: .refreshFavorite, object: nil), perform: { _ in
            presenter.getGameEntities()
        })
    }
}
