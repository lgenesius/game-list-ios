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
