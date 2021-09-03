import Foundation

class GameCoreDataViewModel: ObservableObject {
    @Published var savedEntities: [GameEntity] = []
    
    init() {
        fetchGames()
    }
    
    func fetchGames() {
        savedEntities = CoreDataManager.shared.fetchAllGameEntity()
    }
}
