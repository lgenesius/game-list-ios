import SwiftUI

struct AboutView: View {
    
    @State var name: String = UserDefaults.standard.string(forKey: "profileName") ?? "No Name"
    @State var origin: String = UserDefaults.standard.string(forKey: "profileOrigin") ?? "No Origin"
    @State var description: String = UserDefaults.standard.string(forKey: "profileDescription") ?? "No Description"
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    VStack {
                        Image("me")
                            .circularImageStyle()
                            .padding(.top, 20)
                        
                        Text(self.name)
                            .bigTitleStyle()
                            .padding(.top, 15)
                        
                        Text(self.origin)
                            .titleCardStyle()
                            .padding(.top, 1)
                        
                        VStack {
                            
                            HStack {
                                Text("Tentang Saya")
                                    .titleCardStyle()
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                                    .padding(.bottom, 5)
                                Spacer()
                            }
                            HStack {
                                Text(self.description)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle(Text("About Me"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                NavigationLink(
                    destination: EditProfileView(),
                    label: {
                        Text("Edit Profile")
                    })
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: .refreshAbout, object: nil), perform: { _ in
            name = UserDefaults.standard.string(forKey: "profileName") ?? "No Name"
            origin = UserDefaults.standard.string(forKey: "profileOrigin") ?? "No Origin"
            description = UserDefaults.standard.string(forKey: "profileDescription") ?? "No Description"
        })
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
