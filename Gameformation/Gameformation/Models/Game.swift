import Foundation

struct GameResponse: Codable {
    let next: String?
    let previous: String?
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case next
        case previous
        case games = "results"
    }
}

struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let overallRating: Double
    let platforms: [Platform]?
    let publishers: [Publisher]?
    let gameDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case overallRating = "rating"
        case platforms
        case publishers
        case gameDescription = "description_raw"
    }
    
    var backgroundImageURL: URL? {
        guard let imageURL = self.backgroundImage else { return nil }
        let url = URL(string: imageURL)
        return url
    }
}
