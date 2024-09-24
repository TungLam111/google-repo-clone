import Foundation

class DatasourceDependencyInjection {
    
    var networkService: NetworkServiceContract;
    var authorizationLocalStorage: AuthenticationLocalStorage;
    
    init(networkService: NetworkServiceContract, authorizationLocalStorage: AuthenticationLocalStorage) {
        self.networkService = networkService
        self.authorizationLocalStorage = authorizationLocalStorage
    }
    
    private(set) lazy var getFoodDataSourceRemoteContract : GoogleRepoDataSourceRemoteContract = GoogleRepoDataSourceRemote(
        networkContract: self.networkService,
        authenticationLocalStorage: self.authorizationLocalStorage
    );
    
    private(set) lazy var getFoodDataSourceLocalContract: GoogleRepoDataSourceLocalContract = GoogleRepoDataSourceLocal()
}
