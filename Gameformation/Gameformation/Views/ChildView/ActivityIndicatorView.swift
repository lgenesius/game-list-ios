import SwiftUI

struct ActivityIndicatorView: View {
    let isLoading: Bool
    let error: NSError?
    let reprocess: (() -> Void)
    
    var body: some View {
        HStack {
            Spacer()
            if isLoading {
                UIActivityIndicator()
            } else if error != nil {
                errorView
            }
            Spacer()
        }
    }
    
    var errorView: some View {
        VStack(spacing: 20) {
            Text("Error occured while fetching data \(error?.localizedDescription ?? "")")
                .font(.title3)
            Button(action: {
                self.reprocess()
            }, label: {
                Text("Try Again")
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
        }
    }
}
