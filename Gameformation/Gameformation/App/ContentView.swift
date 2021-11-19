import SwiftUI

struct ContentView: View {
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
            FavoriteView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                }
                .tag(1)
            AboutView()
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
