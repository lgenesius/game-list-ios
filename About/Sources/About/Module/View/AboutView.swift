//
//  File.swift
//  
//
//  Created by Luis Genesius on 03/12/21.
//

import SwiftUI
import GamePackage
import Common

public struct AboutView: View {
    public var presenter: AboutPresenter
    
    public init(presenter: AboutPresenter) {
        self.presenter = presenter
    }
    
    public var body: some View {
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
            .navigationTitle(Text("about_me".localized()))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
