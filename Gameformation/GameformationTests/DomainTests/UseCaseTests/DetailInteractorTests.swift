//
//  DetailInteractorTests.swift
//  GameformationTests
//
//  Created by Luis Genesius on 20/11/21.
//

import XCTest
import Combine
import DetailGame
import GamePackage
@testable import Gameformation

class DetailInteractorTests: XCTestCase {
    private let detailUseCase: DetailInteractor<
        GameModel,
        DetailGameModel,
        GameRemoteRepository<
            GameRemoteDataSource>,
            GameLocalRepository<
                GameLocalDataSource>
    > = Injection().provideDetailUseCase(id: 3498) // id for Grand Theft Auto V

    private var cancelables: Set<AnyCancellable> = []

    func testGetGame() {
        let expectation = self.expectation(description: "GetGame")

        var error: Error?
        var game: DetailGameModel?

        detailUseCase.getResponse()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encountedError):
                    error = encountedError
                }

                expectation.fulfill()
            } receiveValue: { gameAPI in
                game = gameAPI
            }
            .store(in: &cancelables)

        waitForExpectations(timeout: 5)

        XCTAssertNil(error)
        XCTAssertNotNil(game)

        let gtaV = "Grand Theft Auto V"

        XCTAssertEqual(gtaV, game!.name)
    }

    func testAddGame() {
        let expectation = self.expectation(description: "AddGameEntity")
        var status = false

        let gameName = "Grand Theft Auto V"
        let backgroundImage = "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"
        let gameRequest = GameModel(id: 3498, name: gameName, released: "2013-09-17", backgroundImage: backgroundImage, overallRating: 4.48)
        detailUseCase.add(request: gameRequest)
            .sink { statusAddGame in
                status = statusAddGame
                expectation.fulfill()
            }
            .store(in: &cancelables)

        waitForExpectations(timeout: 5)

        XCTAssertEqual(true, status)
    }

    func testGetGameEntity() {
        let expectation = self.expectation(description: "GetGameEntity")
        var error: Error?
        var gameEntity: DetailGameModel?

        detailUseCase.getEntity()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encountedError):
                    error = encountedError
                }

                expectation.fulfill()
            } receiveValue: { incomingGame in
                gameEntity = incomingGame
            }
            .store(in: &cancelables)

        waitForExpectations(timeout: 5)

        XCTAssertNil(error)
    }

    func testDeleteGame() {
        let secondExpectation = self.expectation(description: "DeleteGameEntity")
        var status = false

        detailUseCase.delete()
            .sink { statusDelete in
                status = statusDelete
                secondExpectation.fulfill()
            }
            .store(in: &cancelables)

        waitForExpectations(timeout: 5)

        XCTAssertEqual(true, status)
    }
}
