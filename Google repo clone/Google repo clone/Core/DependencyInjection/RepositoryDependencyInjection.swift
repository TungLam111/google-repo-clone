import Foundation

class RepositoriesDependencyInjection {
    
    var datasourcesDI: DatasourceDependencyInjection;
    
    init(datasourcesDI: DatasourceDependencyInjection) {
        self.datasourcesDI = datasourcesDI
    }
    
    private(set) lazy var ggGithubRepoContract = GoogleGithubRepository(
            remoteDataSource: self.datasourcesDI.getFoodDataSourceRemoteContract ,
            localDataSource: self.datasourcesDI.getFoodDataSourceLocalContract
        )
}
