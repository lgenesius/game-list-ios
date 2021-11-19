//
//  LocalDataSource.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import CoreData
import Combine

protocol GameLocalDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func getGame(with id: Int) -> AnyPublisher<GameEntity?, Error>
    func addGame(request game: GameRequest) -> AnyPublisher<Bool, Never>
    func deleteGame(game: GameEntity) -> AnyPublisher<Bool, Never>
}

final class GameLocalDataSource {
    static let shared = GameLocalDataSource()
    
    private init() {}
}

extension GameLocalDataSource: GameLocalDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            
            do {
                let games = try PersistentContainer.viewContext.fetch(fetchRequest)
                completion(.success(games))
            } catch {
                PersistentContainer.viewContext.rollback()
                completion(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getGame(with id: Int) -> AnyPublisher<GameEntity?, Error> {
        return Future<GameEntity?, Error> { completion in
            let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(id))
            
            do {
                let games = try PersistentContainer.viewContext.fetch(fetchRequest)
                completion(.success(games.first))
            } catch {
                PersistentContainer.viewContext.rollback()
                completion(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addGame(request game: GameRequest) -> AnyPublisher<Bool, Never> {
        return Future<Bool, Never> { [weak self] completion in
            let game = GameEntity(context: PersistentContainer.viewContext)
            game.id = Int32(game.id)
            game.name = game.name
            game.released = game.released
            game.overallRating = game.overallRating
            game.backgroundImage = game.backgroundImage
            
            do {
                try self?.save()
                completion(.success(true))
            } catch {
                PersistentContainer.viewContext.rollback()
                completion(.success(false))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteGame(game: GameEntity) -> AnyPublisher<Bool, Never> {
        return Future<Bool, Never> { [weak self] completion in
            PersistentContainer.viewContext.delete(game)
            
            do {
                try self?.save()
                completion(.success(true))
            } catch {
                PersistentContainer.viewContext.rollback()
                completion(.success(false))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func save() throws {
        do {
            try PersistentContainer.viewContext.save()
        } catch {
            throw(error)
        }
    }
}
