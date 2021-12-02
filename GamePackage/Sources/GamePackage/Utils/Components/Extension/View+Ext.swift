//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import SwiftUI

extension View {
    public func titleCardStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 20, weight: .semibold))
    }
    
    public func dateCardStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 17, weight: .regular))
    }
    
    public func ratingCardStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 15, weight: .regular))
    }
    
    public func bigTitleStyle() -> some View {
        self.modifier(TextModifier(color: .white, size: 25, weight: .semibold))
    }
    
    public func roundedEdgeCard() -> some View {
        self.modifier(RoundedEdge(width: 2, cornerRadius: 10))
    }
}
