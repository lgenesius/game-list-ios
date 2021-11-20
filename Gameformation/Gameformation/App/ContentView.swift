import SwiftUI

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white ]
    }
    
    var body: some View {
        TabView {
            HomeView(presenter: HomePresenter(homeUseCase: Injection().provideHomeUseCase()))
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(0)
            FavoriteView(presenter: FavoritePresenter(favoriteUseCase: Injection().provideFavoriteUseCase()))
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                }
                .tag(1)
            AboutView(presenter: AboutPresenter(mySelf: Myself()))
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("About")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
