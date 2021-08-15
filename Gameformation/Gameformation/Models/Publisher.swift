import Foundation

struct Publisher: Codable {
    let idem: Int
    let name: String
    let imageBackground: String
    enum CodingKeys: String, CodingKey {
        case idem = "id"
        case name
        case imageBackground = "image_background"
    }
}
