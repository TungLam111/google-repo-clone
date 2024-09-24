import Foundation
import SwiftUI
import Combine

final class DependencyInjector {
    
    static let instance = DependencyInjector()
    private init() {}
    
    private(set) lazy var networkService : NetworkServiceContract = NetworkService();
    
    private(set) lazy var datasourcesDI = DatasourceDependencyInjection(networkService: networkService,
                                                                        authorizationLocalStorage: AuthenticationLocalStorage(defaults: UserDefaults.standard))
    
    private(set) lazy var repositoriesDI = RepositoriesDependencyInjection(datasourcesDI: datasourcesDI)
    
    private(set) lazy var usecasesDI = UsecasesDependencyInjection(repositoriesDI: repositoriesDI)
    
    private(set) lazy var viewModelsDI = ViewModelsDependencyInjector(usecasesDI: usecasesDI)
}
