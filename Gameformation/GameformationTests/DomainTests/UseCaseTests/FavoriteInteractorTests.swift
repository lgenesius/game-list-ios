//
//  FavoriteInteractorTests.swift
//  GameformationTests
//
//  Created by Luis Genesius on 20/11/21.
//

import XCTest
import Combine
import Favorite
import GamePackage
@testable import Gameformation

class FavoriteInteractorTests: XCTestCase {
    private let favoriteUseCase: FavoriteInteractor<Any, GameModel, GameLocalRepository<GameLocalDataSource>> = Injection().provideFavoriteUseCase()
    
    private var cancelable: AnyCancellable?
    
    func testGetGameEntities() {
        cancelable?.cancel()
        cancelable = nil
        
        let expectation = self.expectation(description: "GetGameEntities")
        var error: Error?
        
        cancelable = favoriteUseCase.getEntities(request: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encountedError):
                    error = encountedError
                }
                
                expectation.fulfill()
            } receiveValue: { _ in
                
            }

        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
    }
    
    deinit {
        cancelable?.cancel()
        cancelable = nil
    }
}
