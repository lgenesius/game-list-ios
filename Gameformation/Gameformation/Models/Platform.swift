import Foundation

struct Platform: Codable {
    let platform: DetailPlatform
}

struct DetailPlatform: Codable {
    let idem: Int
    let name: String
    enum CodingKeys: String, CodingKey {
        case idem = "id"
        case name
    }
}
