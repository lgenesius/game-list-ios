import Foundation

struct Game: Codable {
    let idem: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    enum CodingKeys: String, CodingKey {
        case idem = "id"
        case name
        case released
        case backgroundImage = "background_image"
        case rating
    }
}
