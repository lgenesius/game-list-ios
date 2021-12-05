//
//  HomeInteractorTests.swift
//  GameformationTests
//
//  Created by Luis Genesius on 19/11/21.
//

import XCTest
import Combine
import Home
import GamePackage
@testable import Gameformation

class HomeInteractorTests: XCTestCase {
    private let homeUseCase: HomeInteractor<Any, GameModel, GameRemoteRepository<GameRemoteDataSource>> = Injection().provideHomeUseCase()
    
    private var cancelables: Set<AnyCancellable> = []
    
    func testGetGames() {
        let expectation = self.expectation(description: "GetGames")
        
        var error: Error?
        var games: [GameModel] = []
        var nextPage: String?
        
        homeUseCase.list(request: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encountedError):
                    error = encountedError
                }
                
                expectation.fulfill()
            } receiveValue: { values in
                nextPage = values.0
                games = values.1
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertNotNil(nextPage)
        XCTAssertNotEqual([], games)
        
        XCTAssertNotNil(URL(string: nextPage!))
    }
    
    func testSearchGames() {
        let expectation = self.expectation(description: "SearchGames")
        
        var error: Error?
        var games: [GameModel] = []
        var nextPage: String?
        
        let query = "Dota"
        homeUseCase.search(query: query)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encountedError):
                    error = encountedError
                }
                
                expectation.fulfill()
            } receiveValue: { values in
                nextPage = values.0
                games = values.1
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertNotNil(nextPage)
        XCTAssertNotEqual([], games)
        
        XCTAssertNotNil(URL(string: nextPage!))
    }
    
    deinit {
        cancelables.removeAll()
    }
}
