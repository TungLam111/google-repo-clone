//
//  ViewModeTest.swift
//  Google repo cloneTests
//
//  Created by phan dam tung lam on 24/9/24.
//

import XCTest
import Combine

class MockProfileViewModel : ProfileViewModel {
    override init(navigator: any NavigationCoordinator, getGoogleRepositoryListUsecase: GetGoogleRepositoryListUsecase, getGoogleProfileUsecase: GetGoogleProfileUsecase) {
        super.init(navigator: navigator, getGoogleRepositoryListUsecase: getGoogleRepositoryListUsecase, getGoogleProfileUsecase: getGoogleProfileUsecase
        )
    }
    
    override func setup() {}
}

class MockFailGetGoogleRepositoryListUsecase : GetGoogleRepositoryListUsecase {
    override init(ggGithubRepoContract: GoogleGithubRepositoryContract) {
        super.init(ggGithubRepoContract: ggGithubRepoContract)
    }
    
    override func execute(page: Int, limit: Int) async throws -> DataState<[GgRepositoryEntity]?> {
        return DataFailed(error: ErrorException(message: "Internet corruption"))
    }
}

class MockFailGetGoogleProfileUsecase : GetGoogleProfileUsecase {
    override init(ggGithubRepoContract: GoogleGithubRepositoryContract) {
        super.init(ggGithubRepoContract: ggGithubRepoContract)
    }
    
    override func execute() async throws -> DataState<GgProfileEntity?> {
        sleep(2)
        return DataFailed(error: ErrorException(message: "Internet corruption"))
    }
}

class MockCacheGetGoogleProfileUsecase : GetGoogleProfileUsecase {
    override init(ggGithubRepoContract: GoogleGithubRepositoryContract) {
        super.init(ggGithubRepoContract: ggGithubRepoContract)
    }
    
    override func execute() async throws -> DataState<GgProfileEntity?> {
        return DataFailed(
            error: ErrorException(message: "Internet corruption"),
            data: GgProfileEntity(
                id: 1,
                avatarURL: "test",
                description: "test",
                name: "test",
                company: "test",
                blog: "test",
                location: "test",
                followers: 100,
                following: 100
            )
        )
    }
}

class MockCacheGetGoogleRepositoryListUsecase : GetGoogleRepositoryListUsecase {
    override init(ggGithubRepoContract: GoogleGithubRepositoryContract) {
        super.init(ggGithubRepoContract: ggGithubRepoContract)
    }
    
    override func execute(page: Int, limit: Int) async throws -> DataState<[GgRepositoryEntity]?> {
        return DataFailed(
            error: ErrorException(message: "Internet corruption"),
            data: [GgRepositoryEntity(id: 1, nodeID: "test", name: "test", fullName: "test", isPrivate: false, htmlURL: "test", description: "test", fork: false, url: "test", createdAt: "test", updatedAt: "test", pushedAt: "test", gitURL: "test", sshURL: "test", cloneURL: "test", svnURL: "test", homepage: "test", size: 1, stargazersCount: 100, watchersCount: 100, language: "test", hasIssues: true, hasProjects: true, hasDownloads: true, hasWiki: true, hasPages: true, hasDiscussions: true, forksCount: 100, archived: true, disabled: false, openIssuesCount: 10, allowForking: true, isTemplate: true, topics: ["test"], visibility: "test", forks: 10, openIssues: 10, watchers: 10, defaultBranch: "test")]
        )
    }
}

final class ViewModeTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var mockNavigator: MockNavigationCoordinator!
    var mockGetGoogleProfileUsecase: GetGoogleProfileUsecase!
    var mockGetGoogleRepositoryListUsecase: GetGoogleRepositoryListUsecase!
    var mockFailGetGoogleRepositoryListUsecase: MockFailGetGoogleRepositoryListUsecase!
    var mockFailGetGoogleProfileUsecase: MockFailGetGoogleProfileUsecase!
    var mockCacheGetGoogleRepositoryListUsecase: MockCacheGetGoogleRepositoryListUsecase!
    var mockCacheGetGoogleProfileUsecase: MockCacheGetGoogleProfileUsecase!
    
    override func setUp() {
        super.setUp()
        mockNavigator = MockNavigationCoordinator()
        mockGetGoogleProfileUsecase = DependencyInjector.instance.usecasesDI.getGoogleProfileUsecase
        mockGetGoogleRepositoryListUsecase = DependencyInjector.instance.usecasesDI.getGoogleRepositoryListUsecase
        
        mockFailGetGoogleRepositoryListUsecase = MockFailGetGoogleRepositoryListUsecase(ggGithubRepoContract: DependencyInjector.instance.repositoriesDI.ggGithubRepoContract)
        
        mockFailGetGoogleProfileUsecase = MockFailGetGoogleProfileUsecase(ggGithubRepoContract: DependencyInjector.instance.repositoriesDI.ggGithubRepoContract)
        
        mockCacheGetGoogleRepositoryListUsecase = MockCacheGetGoogleRepositoryListUsecase(ggGithubRepoContract: DependencyInjector.instance.repositoriesDI.ggGithubRepoContract)
        
        mockCacheGetGoogleProfileUsecase = MockCacheGetGoogleProfileUsecase(ggGithubRepoContract: DependencyInjector.instance.repositoriesDI.ggGithubRepoContract)
    }
    
    func testInitialValue() throws {
        let viewModel = MockProfileViewModel(
            navigator: MockNavigationCoordinator(), getGoogleRepositoryListUsecase: DependencyInjector.instance.usecasesDI.getGoogleRepositoryListUsecase, getGoogleProfileUsecase: DependencyInjector.instance.usecasesDI.getGoogleProfileUsecase
        )
        
        XCTAssertEqual(viewModel.currentPage, 0)
        XCTAssertEqual(viewModel.hasMorePages, true)
    }
    
    func testGetGoogleProfile_Success() async throws {
        let viewModel = MockProfileViewModel(
            navigator: mockNavigator,
            getGoogleRepositoryListUsecase: mockGetGoogleRepositoryListUsecase,
            getGoogleProfileUsecase: mockGetGoogleProfileUsecase
        )
        
        let expectation = XCTestExpectation(description: "Data is fetched and updated")
        var cancellables: Set<AnyCancellable> = []
        
        // Observe the published property
        viewModel.$ggProfile
            .dropFirst() // Skip the initial nil value
            .sink { value in
                // Verify that the value is updated
                // Then
                XCTAssertEqual(value?.name, "Google")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.getGoogleProfile()
        try await Task.sleep(nanoseconds: 3_000_000_000)
    }
    
    func testGetGoogleRepo_Success() async throws {
        let viewModel = MockProfileViewModel(
            navigator: mockNavigator,
            getGoogleRepositoryListUsecase: mockGetGoogleRepositoryListUsecase,
            getGoogleProfileUsecase: mockGetGoogleProfileUsecase
        )
        
        let expectation = XCTestExpectation(description: "Data is fetched and updated")
        var cancellables: Set<AnyCancellable> = []
        
        // Observe the published property
        viewModel.$ggRepositoryList
            .dropFirst() // Skip the initial nil value
            .sink { value in
                // Verify that the value is updated
                XCTAssertEqual(value?.count, 20)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.getGoogleRepositoryList()
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        XCTAssertEqual(viewModel.currentPage, 1)
    }
    
    func testGetGoogleProfile_Failure() async throws {
        let viewModel = MockProfileViewModel(
            navigator: mockNavigator,
            getGoogleRepositoryListUsecase: mockGetGoogleRepositoryListUsecase,
            getGoogleProfileUsecase: mockFailGetGoogleProfileUsecase
        )
        
        // When
        viewModel.getGoogleProfile()
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        XCTAssertTrue(viewModel.hasError)
    }
    
    func testGetGoogleRepo_Failure() async throws {
        let viewModel = MockProfileViewModel(
            navigator: mockNavigator,
            getGoogleRepositoryListUsecase: mockFailGetGoogleRepositoryListUsecase,
            getGoogleProfileUsecase: mockGetGoogleProfileUsecase
        )

        // When
        viewModel.getGoogleRepositoryList()
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        XCTAssertTrue(viewModel.hasError)
    }
    
    func testCacheGetGoogleProfile_OK() async throws {
        let viewModel = MockProfileViewModel(
            navigator: mockNavigator,
            getGoogleRepositoryListUsecase: mockCacheGetGoogleRepositoryListUsecase,
            getGoogleProfileUsecase: mockCacheGetGoogleProfileUsecase
        )

        // When
        viewModel.getGoogleProfile()
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        XCTAssertTrue(viewModel.hasError)
        XCTAssertEqual(viewModel.ggProfile?.id, 1)
    }
    
    func testCacheGetGoogleRepo_OK() async throws {
        let viewModel = MockProfileViewModel(
            navigator: mockNavigator,
            getGoogleRepositoryListUsecase: mockCacheGetGoogleRepositoryListUsecase,
            getGoogleProfileUsecase: mockCacheGetGoogleProfileUsecase
        )

        // When
        viewModel.getGoogleRepositoryList()
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        XCTAssertTrue(viewModel.hasError)
        XCTAssertEqual(viewModel.ggRepositoryList?.count, 1)
        XCTAssertEqual(viewModel.ggRepositoryList?[0].id, 1)
    }
}
