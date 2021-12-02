//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation
import SwiftUI

public struct ActivityIndicator: ViewRepresentable {
    
    public init() {}
    
    public func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
