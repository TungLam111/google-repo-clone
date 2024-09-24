import Foundation

struct GgProfileEntity: Codable {
    let id: Int
    let avatarURL: String
    let description: String?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let followers: Int
    let following: Int

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
        case description
        case name
        case company
        case blog
        case location
        case followers
        case following
    }
}

extension GgProfileEntity {
    init(from model: GgProfileModel) {
        self.id = model.id
        self.avatarURL = model.avatarURL
        self.description = model.description
        self.name = model.name
        self.company = model.company
        self.blog = model.blog
        self.location = model.location
        self.followers = model.followers
        self.following = model.following
    }
}
