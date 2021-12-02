//
//  LocalDataSource.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import CoreData
import Combine

/*
protocol GameLocalDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func getGame(with id: Int) -> AnyPublisher<GameEntity?, Error>
    func addGame(id: Int, name: String?, released: String?, overallRating: Double, backgroundImage: String?) -> AnyPublisher<Bool, Never>
    func deleteGame(id: Int) -> AnyPublisher<Bool, Never>
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
    
    func addGame(id: Int, name: String?, released: String?, overallRating: Double, backgroundImage: String?) -> AnyPublisher<Bool, Never> {
        return Future<Bool, Never> { [weak self] completion in
            let game = GameEntity(context: PersistentContainer.viewContext)
            game.id = Int32(id)
            game.name = name
            game.released = released
            game.overallRating = overallRating
            game.backgroundImage = backgroundImage
            
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
    
    func deleteGame(id: Int) -> AnyPublisher<Bool, Never> {
        return Future<Bool, Never> { [weak self] completion in
            let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(id))
            
            do {
                let games = try PersistentContainer.viewContext.fetch(fetchRequest)
                guard let gameEntity = games.first else {
                    completion(.success(false))
                    return
                }
                
                PersistentContainer.viewContext.delete(gameEntity)
                
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
*/
