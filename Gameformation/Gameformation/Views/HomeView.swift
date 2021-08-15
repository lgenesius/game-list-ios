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
            Text("Hello")
                .navigationBarTitle("Gameformation")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
