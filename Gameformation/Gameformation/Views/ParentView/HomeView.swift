//
//  HomeView.swift
//  Gameformation
//
//  Created by Luis Genesius on 15/08/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var gameListViewModel = GameListViewModel()
    @ObservedObject var gameSearchViewModel = GameSearchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack {
                        
                        SearchBarView(placeholder: "Search any games...", text: self.$gameSearchViewModel.query)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        ActivityIndicatorView(isLoading: self.gameSearchViewModel.isLoading, error: self.gameSearchViewModel.error) {
                            self.gameSearchViewModel.search(query: self.gameSearchViewModel.query)
                        }
                        
                        if let gameResults = gameSearchViewModel.games {
                            ForEach(gameResults) { game in
                                CardView(game: game)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Gameformation")
        }
        .onAppear {
            gameSearchViewModel.beginProcess()
        }
    }
}

/*
 struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
*/
