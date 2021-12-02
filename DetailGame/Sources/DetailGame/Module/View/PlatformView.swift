//
//  File.swift
//  
//
//  Created by Luis Genesius on 01/12/21.
//

import SwiftUI

public struct PlatformView: View {
    let platformName: String
    
    public init(platformName: String) {
        self.platformName = platformName
    }
    
    public var body: some View {
        Text(platformName)
            .foregroundColor(.black)
            .font(Font.system(size: 12))
            .padding(.all, 10)
            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            .cornerRadius(10)
    }
}
