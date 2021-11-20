import SwiftUI

struct AboutView: View {
    var presenter: AboutPresenter
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    VStack {
                        Image(presenter.getImageName())
                            .circularImageStyle()
                            .padding(.top, 20)
                        
                        Text(presenter.getName())
                            .bigTitleStyle()
                            .padding(.top, 15)
                        
                        Text(presenter.getOrigin())
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
                                Text(presenter.getDescription())
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
    }
}
