//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation
import SwiftUI

public struct ActivityIndicatorView: View {
    let isLoading: Bool
    let error: NSError?
    let reprocess: (() -> Void)
    
    public init(isLoading: Bool, error: NSError?, reprocess: @escaping (() -> Void)) {
        self.isLoading = isLoading
        self.error = error
        self.reprocess = reprocess
    }
    
    public var body: some View {
        HStack {
            Spacer()
            if isLoading {
                ActivityIndicator()
            } else if error != nil {
                errorView
            }
            Spacer()
        }
    }
    
    public var errorView: some View {
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
