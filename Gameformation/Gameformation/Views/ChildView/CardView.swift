//
//  CardView.swift
//  Gameformation
//
//  Created by Luis Genesius on 15/08/21.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "house")
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
    }
    
    var textVStack: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Hello")
                .titleCardStyle()
            Text("Tanggal Rlis")
                .dateCardStyle()
            HStack(spacing: 5) {
                Text("4.86")
                    .foregroundColor(.white)
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .lineLimit(1)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
