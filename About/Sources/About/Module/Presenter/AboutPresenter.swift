//
//  File.swift
//  
//
//  Created by Luis Genesius on 03/12/21.
//

import Foundation

public class AboutPresenter {
    private let mySelf: Myself
    
    public init(mySelf: Myself) {
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
