import Foundation

struct GgRepositoryModel: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: OwnerModel
    let htmlURL: String
    let description: String?
    let fork: Bool
    let url: String
    let createdAt: String
    let updatedAt: String
    let pushedAt: String
    let gitURL: String
    let sshURL: String
    let cloneURL: String
    let svnURL: String
    let homepage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let hasIssues, hasProjects, hasDownloads, hasWiki, hasPages, hasDiscussions: Bool
    let forksCount: Int
    let archived, disabled: Bool
    let openIssuesCount: Int
    let license: LicenseModel?
    let allowForking: Bool
    let isTemplate: Bool
    let topics: [String]
    let visibility: String
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let defaultBranch: String
    let permissions: PermissionsModel

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description
        case fork
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDiscussions = "has_discussions"
        case forksCount = "forks_count"
        case archived
        case disabled
        case openIssuesCount = "open_issues_count"
        case license
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case topics
        case visibility
        case forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        case permissions
    }
}

struct OwnerModel: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let url: String
    let htmlURL: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case type
        case siteAdmin = "site_admin"
    }
}

struct LicenseModel: Codable {
    let key: String
    let name: String
    let spdxID: String
    let url: String?
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key
        case name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

// MARK: - Permissions Model
struct PermissionsModel: Codable {
    let admin: Bool
    let maintain: Bool
    let push: Bool
    let triage: Bool
    let pull: Bool
}
