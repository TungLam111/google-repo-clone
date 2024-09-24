import Foundation

struct GgRepositoryEntity: Codable, Identifiable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let isPrivate: Bool
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
    let allowForking: Bool
    let isTemplate: Bool
    let topics: [String]
    let visibility: String
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
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
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case topics
        case visibility
        case forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
    }
}

extension GgRepositoryEntity {
    init(from model: GgRepositoryModel) {
        self.id = model.id
        self.nodeID = model.nodeID
        self.name = model.name
        self.fullName = model.fullName
        self.isPrivate = model.isPrivate
        self.htmlURL = model.htmlURL
        self.description = model.description
        self.fork = model.fork
        self.url = model.url
        self.createdAt = model.createdAt
        self.updatedAt = model.updatedAt
        self.pushedAt = model.pushedAt
        self.gitURL = model.gitURL
        self.sshURL = model.sshURL
        self.cloneURL = model.cloneURL
        self.svnURL = model.svnURL
        self.homepage = model.homepage
        self.size = model.size
        self.stargazersCount = model.stargazersCount
        self.watchersCount = model.watchersCount
        self.language = model.language
        self.hasIssues = model.hasIssues
        self.hasProjects = model.hasProjects
        self.hasDownloads = model.hasDownloads
        self.hasWiki = model.hasWiki
        self.hasPages = model.hasPages
        self.hasDiscussions = model.hasDiscussions
        self.forksCount = model.forksCount
        self.archived = model.archived
        self.disabled = model.disabled
        self.openIssuesCount = model.openIssuesCount
        self.allowForking = model.allowForking
        self.isTemplate = model.isTemplate
        self.topics = model.topics
        self.visibility = model.visibility
        self.forks = model.forks
        self.openIssues = model.openIssues
        self.watchers = model.watchers
        self.defaultBranch = model.defaultBranch
    }
}
