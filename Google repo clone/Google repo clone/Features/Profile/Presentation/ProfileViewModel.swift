import Foundation
import SwiftUI
import Combine

class ProfileViewModel: BaseViewModel {
    var navigator: NavigationCoordinator;
    var getGoogleProfileUsecase: GetGoogleProfileUsecase;
    var getGoogleRepositoryListUsecase: GetGoogleRepositoryListUsecase;

    @Published var ggRepositoryList: [GgRepositoryEntity]? = [];
    @Published var ggProfile: GgProfileEntity? = nil;
    @Published var loadListState: LoadState = LoadState.initial;
    
    var currentPage = 0
    var hasMorePages: Bool = true

    init(
        navigator: NavigationCoordinator,
        getGoogleRepositoryListUsecase: GetGoogleRepositoryListUsecase,
        getGoogleProfileUsecase: GetGoogleProfileUsecase
    ) {
        self.navigator = navigator
        self.getGoogleProfileUsecase = getGoogleProfileUsecase
        self.getGoogleRepositoryListUsecase = getGoogleRepositoryListUsecase
        super.init()
        
        mockTokenForTesting()
        
        setup()
    }
    
    func mockTokenForTesting() {
        let authStorage = AuthenticationLocalStorage(defaults: UserDefaults.standard)
        let accessToken = authStorage.getAccessToken()
        if (accessToken == nil || accessToken == "") {
            _ = authStorage.saveAccessToken(token: "xxx")
        }
    }
    
    func setup() {
        getGoogleProfile();
        getGoogleRepositoryList();
    }
    
    func getGoogleProfile() {
        DispatchQueue.main.async {
            Task {
                do {
                    let dataState : DataState<GgProfileEntity?> = try await self.getGoogleProfileUsecase.execute();
                    if (dataState.isSuccess) {
                        self.ggProfile = dataState.data ?? nil;
                    } else {
                        self.hasError = true;
                        self.ggProfile = dataState.data ?? nil
                        self.errorMessage = dataState.error?.message
                    }
                } catch {
                    print("Error fetching profile: \(error)")
                    self.hasError = true;
                    self.errorMessage = "Something went wrong"
                }
            }
        }
    }
    
    func getGoogleRepositoryList() {
        DispatchQueue.main.async {
            Task {
                self.mainLoadingStatus.toggle()
                do {
                    guard self.loadListState != LoadState.loading && self.hasMorePages else { return }
                    self.loadListState = LoadState.loading;
                    
                    let dataState = try await self.getGoogleRepositoryListUsecase.execute(
                        page: self.currentPage, limit: 20
                    )
                    self.mainLoadingStatus.toggle()
                    
                    if (dataState.isError) {
                        self.hasError = true
                        self.errorMessage = dataState.error?.message
                        self.loadListState = LoadState.error
                        self.ggRepositoryList = dataState.data ?? []
                        return
                    }
                    
                    self.ggRepositoryList?.append(contentsOf: (dataState.data ?? []) ?? [])
                    self.currentPage = self.currentPage + 1
                                        
                    if (dataState.data != nil && ((dataState.data ?? []) ?? []).count < 20) {
                        self.hasMorePages = false
                        self.loadListState = LoadState.empty
                        return;
                    }
                    self.loadListState = LoadState.ok
                    
                } catch {
                    // Handle error if needed
                    print("Error fetching repos: \(error)")
                    self.mainLoadingStatus.toggle()
                    self.loadListState = LoadState.error
                    
                    self.hasError = true;
                    self.errorMessage = "Something went wrong"
                }
            }
        }
    }
}
