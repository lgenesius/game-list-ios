//
//  TextModifier.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import SwiftUI

struct TextModifier: ViewModifier {
    let color: Color
    let size: CGFloat
    let weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(Font.system(size: size, weight: weight, design: .default))
    }
}
