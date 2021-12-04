import SwiftUI
import Home
import GamePackage
import DetailGame
import Favorite
import About
import Common

struct ContentView: View {
    @StateObject var homePresenter: HomePresenter = HomePresenter(homeUseCase: Injection().provideHomeUseCase())
    @StateObject var favoritePresenter: FavoritePresenter = FavoritePresenter(favoriteUseCase: Injection().provideFavoriteUseCase())
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white ]
    }
    
    var body: some View {
        TabView {
            HomeView(presenter: homePresenter, destination: { id in
                DetailView(presenter: DetailPresenter(parentView: .home, detailUseCase: Injection().provideDetailUseCase(id: id)))
            })
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("home".localized())
                    }
                }
                .tag(0)
            
            FavoriteView(presenter: favoritePresenter, destination: { id in
                DetailView(presenter: DetailPresenter(parentView: .favorite, detailUseCase: Injection().provideDetailUseCase(id: id)))
            })
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("favorites".localized())
                    }
                }
                .tag(1)
            
            AboutView(presenter: AboutPresenter(mySelf: Myself()))
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("about".localized())
                    }
                }
                .tag(2)
        }
        .onAppear {
            print("favorite".localized())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
