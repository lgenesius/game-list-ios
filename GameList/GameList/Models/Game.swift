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

struct Game: Codable {
    let idem: Int
    let name: String
    let released: String
    let backgroundImage: String
    let overallRating: Double
    enum CodingKeys: String, CodingKey {
        case idem = "id"
        case name
        case released
        case backgroundImage = "background_image"
        case overallRating = "rating"
    }
}

struct DetailGame: Codable {
    let idem: Int
    let name: String
    let released: String
    let backgroundImage: String
    let overallRating: Double
    let platforms: [Platform]
    let gameDescription: String
    enum CodingKeys: String, CodingKey {
        case idem = "id"
        case name
        case released
        case backgroundImage = "background_image"
        case overallRating = "rating"
        case platforms
        case gameDescription = "description_raw"
    }
}
