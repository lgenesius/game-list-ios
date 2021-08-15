import Foundation

struct Publisher: Codable, Identifiable {
    let id: Int
    let name: String
    let imageBackground: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageBackground = "image_background"
    }
}
