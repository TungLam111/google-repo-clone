import Foundation

struct GgProfileModel: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let url: String
    let reposURL: String
    let eventsURL: String
    let hooksURL: String
    let issuesURL: String
    let membersURL: String
    let publicMembersURL: String
    let avatarURL: String
    let description: String?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let twitterUsername: String?
    let isVerified: Bool
    let hasOrganizationProjects: Bool
    let hasRepositoryProjects: Bool
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let htmlURL: String
    let createdAt: String
    let updatedAt: String
    let archivedAt: String?
    let type: String

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case url
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case hooksURL = "hooks_url"
        case issuesURL = "issues_url"
        case membersURL = "members_url"
        case publicMembersURL = "public_members_url"
        case avatarURL = "avatar_url"
        case description
        case name
        case company
        case blog
        case location
        case email
        case twitterUsername = "twitter_username"
        case isVerified = "is_verified"
        case hasOrganizationProjects = "has_organization_projects"
        case hasRepositoryProjects = "has_repository_projects"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case htmlURL = "html_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case archivedAt = "archived_at"
        case type
    }
}
