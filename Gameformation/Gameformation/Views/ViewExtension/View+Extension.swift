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
    
    func roundedEdgeCard() -> some View {
        self.modifier(RoundedEdge(width: 2, cornerRadius: 10))
    }
}
