import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Hello")
                .navigationBarTitle("List of Games")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
