import Foundation
import Combine

class GoogleGithubRepository : GoogleGithubRepositoryContract {
    
    private var remoteDataSource: GoogleRepoDataSourceRemoteContract;
    private var localDataSource: GoogleRepoDataSourceLocalContract;
    
    init(
        remoteDataSource: GoogleRepoDataSourceRemoteContract,
        localDataSource: GoogleRepoDataSourceLocalContract
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getRepositoryList(page: Int, limit: Int) async throws -> DataState<[GgRepositoryEntity]?> {
        do {
            let (repos, err) : ([GgRepositoryModel]?, Error?) = try await self.remoteDataSource.getGoogleRepositoryList(page: page, limit: limit)
            // transform model to entity
            if (err != nil) {
                return DataFailed(error: ErrorException(message: err?.localizedDescription), data: repos == nil ? nil : repos!.map { ggRepoModel in
                    GgRepositoryEntity(from: ggRepoModel)
                })
            }
            return DataSuccess(data: repos!.map { ggRepoModel in
                GgRepositoryEntity(from: ggRepoModel)
            })
        } catch {
            print("Error fetching repos: \(error)")
            return DataFailed(error: ErrorException(message: error.localizedDescription))
        }
    }
    
    func getProfile() async throws -> DataState<GgProfileEntity?> {
        do {
            let (profile, err) : (GgProfileModel?, Error?) = try await self.remoteDataSource.getGoogleProfile()
            if (err != nil) {
                return DataFailed(error: ErrorException(message: err?.localizedDescription), data: profile == nil ? nil : GgProfileEntity(from: profile!));
            }
            
            let profileEntity : GgProfileEntity = GgProfileEntity(from: profile!);
            return DataSuccess(data: profileEntity);
        } catch {
            print("Error fetching profile: \(error)")
            return DataFailed(error: ErrorException(message: error.localizedDescription))
        }
    }
}
