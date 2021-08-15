import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            Text("Hello")
                .navigationBarTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
