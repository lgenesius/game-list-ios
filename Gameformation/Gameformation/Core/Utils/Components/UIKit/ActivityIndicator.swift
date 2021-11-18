import SwiftUI

struct ActivityIndicator: ViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
