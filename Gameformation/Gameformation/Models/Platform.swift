import Foundation

struct Platform: Codable {
    let platform: DetailPlatform
}

struct DetailPlatform: Codable, Identifiable {
    let id: Int
    let name: String
}
