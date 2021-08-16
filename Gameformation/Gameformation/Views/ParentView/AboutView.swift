//
//  AboutView.swift
//  Gameformation
//
//  Created by Luis Genesius on 15/08/21.
//

import SwiftUI

struct AboutView: View {
    
    private let myBackground = "Saya adalah mahasiswa universitas Bina Nusantara yang mengambil jurusan Teknik Informatika."
    private let myPurpose = "Memiliki tujuan untuk menjadi seorang iOS Developer yang handal."
    private let myPassion = "Saya memiliki passion untuk mengembangkan aplikasi karena"
    private let myReason = "dapat menghasilkan sebuah produk yang bisa memberikan manfaat bagi banyak orang."
    
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
                            
                            Text("Luis Genesius")
                                .bigTitleStyle()
                                .padding(.top, 15)
                            
                            Text("Singkawang, Kalimantan Barat")
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
                                    Text(myBackground + " " + myPurpose)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(myPassion + " " + myReason)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.top, 5)
                                    Spacer()
                                }
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("About Me")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
