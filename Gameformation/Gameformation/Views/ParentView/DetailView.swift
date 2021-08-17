import SwiftUI

struct DetailView: View {
    let gameId: Int
    @ObservedObject var detailGameViewModel = DetailGameViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ActivityIndicatorView(isLoading: self.detailGameViewModel.isLoading, error: self.detailGameViewModel.error) {
                self.detailGameViewModel.loadGame(id: gameId)
            }
            
            ScrollView {
                LazyVStack {
                    if let game = detailGameViewModel.game {
                        DetailImage(imageURL: game.backgroundImageURL)
                        
                        if let platforms = game.platforms {
                            PlatformsView(platforms: platforms)
                        }
                        
                        if let gameDescription = game.gameDescription {
                            HStack {
                                Text(gameDescription)
                                    .foregroundColor(.white)
                                    .font(Font.system(size: 17))
                                    .padding()
                                Spacer()
                            }
                        }
                        
                        RatingReleasedDateView(game: game)

                        if let publishers = game.publishers {
                            PublisherView(publishers: publishers)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(detailGameViewModel.game?.name ?? ""))
        .onAppear {
            self.detailGameViewModel.loadGame(id: gameId)
        }
    }
}

struct DetailImage: View {
    let imageURL: URL?
    @ObservedObject var imageLoaderService = ImageLoaderService()
    
    var body: some View {
        imageShowUp
            .resizable()
            .aspectRatio(16/9, contentMode: .fill)
            .onAppear {
                if let url = imageURL {
                    imageLoaderService.loadImage(with: url)
                }
            }
    }
    
    var imageShowUp: Image {
        guard let image = imageLoaderService.image else {
            return Image(systemName: "questionmark.square")
        }
        return Image(uiImage: image)
    }
}

struct PlatformsView: View {
    let platforms: [Platform]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(platforms, id: \.self) { platform in
                    PlatformView(platformName: platform.platform.name)
                        .padding(.horizontal, 5)
                }
            }
        }
        .padding(.top, 5)
        .padding(.horizontal)
    }
}

struct RatingReleasedDateView: View {
    let game: Game
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            VStack(spacing: 10) {
                Text("The Rating:")
                    .titleCardStyle()
                HStack {
                    Text(String(game.overallRating))
                        .foregroundColor(.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            
            VStack(spacing: 10) {
                Text("Released:")
                    .titleCardStyle()
                Text(String(game.released ?? "No Data"))
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
        }
    }
}

struct PublisherView: View {
    let publishers: [Publisher]
    
    var body: some View {
        HStack {
            Text("Publisher(s):")
                .titleCardStyle()
                .padding(.horizontal)
            Spacer()
        }
        .padding(.top, 15)
        .padding(.bottom, 2)
        VStack {
            ForEach(publishers, id: \.self) { publisher in
                HStack {
                    Text(publisher.name)
                        .dateCardStyle()
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    Spacer()
                }
            }
        }
        .padding(.bottom, 15)
    }
}
