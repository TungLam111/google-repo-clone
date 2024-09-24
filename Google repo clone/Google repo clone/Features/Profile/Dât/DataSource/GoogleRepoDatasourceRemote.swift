
import Foundation
import Combine

protocol GoogleRepoDataSourceRemoteContract : DataSourceRemoteContract {
    func getGoogleProfile() async throws -> (GgProfileModel?, Error?);
    func getGoogleRepositoryList(page: Int, limit: Int) async throws -> ([GgRepositoryModel]?, Error?);
}

final class GoogleRepoDataSourceRemote :
    GoogleRepoDataSourceRemoteContract {
    private var networkContract: NetworkServiceContract;
    private var authenticationLocalStorage: AuthenticationLocalStorage;
    private var cacheService : CacheLayer = CacheLayer(
        memoryCapacity: 20 * 1024 * 1024,
        diskCapacity: 100 * 1024 * 1024,
        cacheExpirationTime: 60 * 5
    )
    
    init(
        networkContract: NetworkServiceContract,
        authenticationLocalStorage: AuthenticationLocalStorage
    ) {
        self.networkContract = networkContract;
        self.authenticationLocalStorage = authenticationLocalStorage;
    }
    
    func getGoogleProfile() async throws -> (GgProfileModel?, Error?) {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.profilePath,
            headers: headers,
            queries: nil
        )
        
        let (data, urlResponse, urlRequest, err) = try await self.networkContract.fetchConcurrency(
            type: GgProfileModel?.self,
            customUrl: formEndpoint.url,
            headers: headers,
            body: nil,
            method: "GET"
        );
        
        if (err == nil) {
            if (urlResponse != nil) {
                self.cacheService.saveResponse(data: data, for: urlRequest, response: urlResponse!);
            }
            return (data!, err)
        }
        
        let cachedData : GgProfileModel? = self.cacheService.getCachedResponse(for: urlRequest)
        return (cachedData, err)
    }
    
    func getGoogleRepositoryList(page: Int, limit: Int) async throws -> ([GgRepositoryModel]?, Error?) {
        var queries: [String: String] = [:]
        queries["page"] = "\(page)"
        queries["per_page"] = "\(limit)"
        
        let headers = formHeaders(customHeaders: [
            "X-GitHub-Api-Version" : "2022-11-28",
            "Accept": "application/vnd.github+json"
          ]
        )
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.repoPath,
            headers: headers,
            queries: queries
        )
        let (data, urlResponse, urlRequest, err) = try await self.networkContract.fetchConcurrency(
            type: [GgRepositoryModel]?.self,
            customUrl: formEndpoint.url,
            headers: headers,
            body: nil,
            method: "GET"
        );
        if (err == nil) {
            if (urlResponse != nil) {
                self.cacheService.saveResponse(data: data, for: urlRequest, response: urlResponse!);
            }
            return (data!, err)
        }
        
        let cachedData : [GgRepositoryModel]? = self.cacheService.getCachedResponse(for: urlRequest)
        return (cachedData, err)
    }
    
    func getAuthorizationStorage() -> AuthenticationLocalStorage {
        return self.authenticationLocalStorage;
    }
}
