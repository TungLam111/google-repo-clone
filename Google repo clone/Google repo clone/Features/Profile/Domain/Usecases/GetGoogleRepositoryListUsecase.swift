import Foundation

class GetGoogleRepositoryListUsecase {
    private var ggGithubRepoContract : GoogleGithubRepositoryContract;
    
    init(ggGithubRepoContract: GoogleGithubRepositoryContract) {
        self.ggGithubRepoContract = ggGithubRepoContract
    }
    
    func execute(page: Int, limit: Int) async throws -> DataState<[GgRepositoryEntity]?> {
        return try await self.ggGithubRepoContract.getRepositoryList(page: page, limit: limit);
    }
}
