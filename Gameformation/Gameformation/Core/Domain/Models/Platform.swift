struct Platform: Codable, Hashable {
    let platform: DetailPlatform
}

struct DetailPlatform: Codable, Hashable {
    let id: Int
    let name: String
}
