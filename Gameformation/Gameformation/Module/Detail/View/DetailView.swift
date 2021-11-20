import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ScrollView {
            ActivityIndicatorView(isLoading: presenter.isLoading, error: presenter.error) {
                presenter.getGame()
            }
            
            LazyVStack {
                if let game = presenter.game {
                    DetailImageView(imageManager: ImageManager(url: game.backgroundImageURL))
                    
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
        .navigationTitle(Text(presenter.game?.name ?? ""))
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button(action: {
                    presenter.trailingToolbarAction()
                }, label: {
                    Text(presenter.setTrailingToolbarText())
                })
                    .disabled(presenter.disableToolbar())
            }
        })
        .onAppear {
            presenter.getGame()
            presenter.setFavoriteStatus()
        }
    }
}

struct DetailImageView: View {
    @ObservedObject var imageManager: ImageManager
    
    var body: some View {
        VStack {
            if imageManager.image != nil {
                Image(uiImage: imageManager.image!)
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fill)
            } else {
                if #available(iOS 15.0, *) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width / 16) * 9)
                        .overlay {
                            if imageManager.isLoading {
                                ActivityIndicator()
                            } else {
                                Text("No Image")
                                    .foregroundColor(.black)
                                    .font(Font.system(.largeTitle, design: .default))
                            }
                        }
                } else {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width / 16) * 9)
                        .overlay(
                            ZStack {
                                if imageManager.isLoading {
                                    ActivityIndicator()
                                } else {
                                    Text("No Image")
                                        .foregroundColor(.black)
                                        .font(Font.system(.largeTitle, design: .default))
                                }
                            }
                        )
                }
            }
        }
        .padding(.bottom, 5)
        .onAppear {
            imageManager.load()
        }
        .onDisappear {
            imageManager.cancel()
        }
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
