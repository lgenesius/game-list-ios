import SwiftUI

struct AboutView: View {
    
    @State var name: String = UserDefaults.standard.string(forKey: "profileName") ?? "No Name"
    @State var origin: String = UserDefaults.standard.string(forKey: "profileOrigin") ?? "No Origin"
    @State var description: String = UserDefaults.standard.string(forKey: "profileDescription") ?? "No Description"
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
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
            }
            .navigationBarTitle("About Me")
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(
                        destination: EditProfileView(),
                        label: {
                            Text("Edit Profile")
                        })
                }
            })
        }
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
