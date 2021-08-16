import SwiftUI

extension View {
    func titleCardStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 20, weight: .semibold))
    }
    
    func dateCardStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 17, weight: .regular))
    }
    
    func ratingCardStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 15, weight: .regular))
    }
    
    func bigTitleStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 25, weight: .semibold))
    }
    
    func roundedEdgeCard() -> some View {
        self.modifier(RoundedEdge(width: 2, cornerRadius: 10))
    }
}

extension Image {
    func circularImageStyle() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}
