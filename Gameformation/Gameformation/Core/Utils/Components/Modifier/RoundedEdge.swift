//
//  RoundedEdge.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import SwiftUI

struct RoundedEdge: ViewModifier {
    let width: CGFloat
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius - width)
            .padding(width)
            .cornerRadius(cornerRadius)
    }
}
