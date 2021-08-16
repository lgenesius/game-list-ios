//
//  CardView.swift
//  Gameformation
//
//  Created by Luis Genesius on 15/08/21.
//

import SwiftUI

struct CardView: View {
    
    let game: Game
    @ObservedObject var imageLoaderService = ImageLoaderService()
    
    var body: some View {
        HStack(spacing: 20) {
            imageShowUp
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)

            textVStack
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
        .roundedEdgeCard()
        .clipped()
        .shadow(color: Color.black, radius: 5, x: 0, y: 0)
        .onAppear {
            if let url = self.game.backgroundImageURL {
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
    
    var textVStack: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(game.name)
                .titleCardStyle()
            Text(game.released ?? "Unknown Release Date")
                .dateCardStyle()
            HStack(spacing: 5) {
                Text(String(game.overallRating))
                    .foregroundColor(.white)
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .lineLimit(1)
    }
}
