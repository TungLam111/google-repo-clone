

import Foundation

class GetGoogleProfileUsecase {
    private var ggGithubRepoContract : GoogleGithubRepositoryContract;
    
    init(ggGithubRepoContract: GoogleGithubRepositoryContract) {
        self.ggGithubRepoContract = ggGithubRepoContract
    }
    
    func execute() async throws -> DataState<GgProfileEntity?> {
        return try await self.ggGithubRepoContract.getProfile();
    }
}
