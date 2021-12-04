//
//  File.swift
//  
//
//  Created by Luis Genesius on 01/12/21.
//

import Core
import CoreData
import Combine

public struct GameLocalDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = GameEntity
    
    public init() {}
    
    public func list(request: Any?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            
            do {
                if PersistentContainer.viewContext != nil {
                    let games = try PersistentContainer.viewContext!.fetch(fetchRequest)
                    completion(.success(games))
                } else {
                    completion(.success([]))
                }
            } catch {
                if PersistentContainer.viewContext != nil {
                    PersistentContainer.viewContext!.rollback()
                }
                completion(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity?, Error> {
        return Future<GameEntity?, Error> { completion in
            let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(id))
            
            do {
                if PersistentContainer.viewContext != nil {
                    let games = try PersistentContainer.viewContext!.fetch(fetchRequest)
                    completion(.success(games.first))
                } else {
                    completion(.success(nil))
                }
            } catch {
                if PersistentContainer.viewContext != nil {
                    PersistentContainer.viewContext!.rollback()
                }
                completion(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func add(id: Int, name: String?, released: String?, overallRating: Double, backgroundImage: String?) -> AnyPublisher<Bool, Never> {
        return Future<Bool, Never> { completion in
            guard PersistentContainer.viewContext != nil else {
                completion(.success(false))
                return
            }
            
            let game = GameEntity(context: PersistentContainer.viewContext!)
            game.id = Int32(id)
            game.name = name
            game.released = released
            game.overallRating = overallRating
            game.backgroundImage = backgroundImage
            
            do {
                try PersistentContainer.viewContext!.save()
                completion(.success(true))
            } catch {
                PersistentContainer.viewContext!.rollback()
                completion(.success(false))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func delete(id: Int) -> AnyPublisher<Bool, Never> {
        return Future<Bool, Never> { completion in
            guard PersistentContainer.viewContext != nil else {
                completion(.success(false))
                return
            }
            
            let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(id))
            
            do {
                let games = try PersistentContainer.viewContext!.fetch(fetchRequest)
                guard let gameEntity = games.first else {
                    completion(.success(false))
                    return
                }
                
                PersistentContainer.viewContext!.delete(gameEntity)
                
                try PersistentContainer.viewContext!.save()
                completion(.success(true))
            } catch {
                PersistentContainer.viewContext!.rollback()
                completion(.success(false))
            }
        }
        .eraseToAnyPublisher()
    }
}
