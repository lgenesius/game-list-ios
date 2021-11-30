//
//  File.swift
//  
//
//  Created by Luis Genesius on 29/11/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    let game: GameModel

    var body: some View {
        HStack(spacing: 20) {
            ImageCardView(imageManager: ImageManager(url: game.backgroundImageURL))

            textVStack
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
        .roundedEdgeCard()
        .clipped()
        .shadow(color: Color.black, radius: 5, x: 0, y: 0)
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

struct ImageCardView: View {
    @ObservedObject var imageManager: ImageManager

    var body: some View {
        ZStack {
            if imageManager.image != nil {
                Image(uiImage: imageManager.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            } else {
                if imageManager.isLoading {
                    if #available(iOS 15.0, *) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 80, height: 80)
                            .overlay {
                                ActivityIndicator()
                            }
                    } else {
                        // Fallback on earlier versions
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 80, height: 80)
                            .overlay(
                                ActivityIndicator()
                            )
                    }
                } else {
                    Image(systemName: "questionmark.square")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            self.imageManager.load()
        }
        .onDisappear {
            self.imageManager.cancel()
        }
    }
}
