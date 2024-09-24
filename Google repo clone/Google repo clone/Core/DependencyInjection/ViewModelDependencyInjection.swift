import Foundation

final class ViewModelsDependencyInjector  {
    var usecasesDI: UsecasesDependencyInjection;
    
    init(usecasesDI: UsecasesDependencyInjection) {
        self.usecasesDI = usecasesDI
    }
    
    
    func profile(navigationCoordinator: NavigationCoordinator) -> ProfileViewModel {
        return ProfileViewModel(
            navigator: navigationCoordinator,
            getGoogleRepositoryListUsecase: self.usecasesDI.getGoogleRepositoryListUsecase, getGoogleProfileUsecase: self.usecasesDI.getGoogleProfileUsecase
        )
    }
}
