//
//  AboutPresenter.swift
//  Gameformation
//
//  Created by Luis Genesius on 20/11/21.
//

import Foundation

class AboutPresenter {
    private let mySelf: Myself
    
    init(mySelf: Myself) {
        self.mySelf = mySelf
    }
    
    func getImageName() -> String {
        mySelf.myImageName
    }
    
    func getName() -> String {
        mySelf.myName
    }
    
    func getOrigin() -> String {
        mySelf.myOrigin
    }
    
    func getDescription() -> String {
        mySelf.myDescription
    }
}
