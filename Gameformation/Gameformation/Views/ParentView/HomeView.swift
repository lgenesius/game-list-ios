//
//  HomeView.swift
//  Gameformation
//
//  Created by Luis Genesius on 15/08/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack {
                        ForEach(0..<10) {_ in
                            CardView()
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationBarTitle("Gameformation")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
