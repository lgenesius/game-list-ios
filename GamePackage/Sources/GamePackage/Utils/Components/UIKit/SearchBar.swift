//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import SwiftUI

typealias ViewRepresentable = UIViewRepresentable

public struct SearchBar: ViewRepresentable {
    let placeholder: String
    @Binding var text: String
    
    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    public func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$text)
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    public class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        public init(text: Binding<String>) {
            _text = text
        }
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}
