
import Foundation

class UsecasesDependencyInjection {
    var repositoriesDI: RepositoriesDependencyInjection
    init(repositoriesDI: RepositoriesDependencyInjection) {
        self.repositoriesDI = repositoriesDI
    }
    
    private(set) lazy var getGoogleProfileUsecase = GetGoogleProfileUsecase(
        ggGithubRepoContract: self.repositoriesDI.ggGithubRepoContract
    );
    
    private(set) lazy var getGoogleRepositoryListUsecase = GetGoogleRepositoryListUsecase(
        ggGithubRepoContract: self.repositoriesDI.ggGithubRepoContract
    );
}
