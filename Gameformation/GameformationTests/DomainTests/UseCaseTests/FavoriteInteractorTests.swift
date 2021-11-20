//
//  FavoriteInteractorTests.swift
//  GameformationTests
//
//  Created by Luis Genesius on 20/11/21.
//

import XCTest
import Combine
@testable import Gameformation

class FavoriteInteractorTests: XCTestCase {
    private let favoriteUseCase = Injection().provideFavoriteUseCase()
    
    private var cancelable: AnyCancellable?
    
    func testGetGameEntities() {
        cancelable?.cancel()
        cancelable = nil
        
        let expectation = self.expectation(description: "GetGameEntities")
        var error: Error?
        
        cancelable = favoriteUseCase.getGameEntities()
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
}
