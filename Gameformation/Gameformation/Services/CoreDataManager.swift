import CoreData

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveData() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save game \(error)")
        }
    }
    
    func addNewFavoriteGame(id: Int, name: String, released: String?, overallRating: Double, backgroundImage: String?) {
        let game = GameEntity(context: persistentContainer.viewContext)
        game.id = Int32(id)
        game.name = name
        game.released = released
        game.overallRating = overallRating
        game.backgroundImage = backgroundImage
        saveData()
    }
    
    func fetchAllGameEntity() -> [GameEntity] {
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func fetchGameEntityBasedOnId(id: Int) -> [GameEntity] {
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(id))
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch game \(error)")
        }
        return []
    }
    
    func deleteGame(game: GameEntity) {
        persistentContainer.viewContext.delete(game)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
}
