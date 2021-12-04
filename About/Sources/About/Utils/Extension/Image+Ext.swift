//
//  File.swift
//  
//
//  Created by Luis Genesius on 03/12/21.
//

import SwiftUI

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
