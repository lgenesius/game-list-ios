//
//  TabRouter.swift
//  Gameformation
//
//  Created by Luis Genesius on 19/11/21.
//

import SwiftUI

final class TabRouter {
    
    func createDetailView(from parentView: ParentView, with id: Int) -> some View {
        let detailUseCase = Injection().provideDetailUseCase(id: id)
        let presenter = DetailPresenter(detailUseCase: detailUseCase, parentView: parentView)
        return DetailView(presenter: presenter)
    }
}
