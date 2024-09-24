

import Foundation
import Combine

protocol GoogleGithubRepositoryContract {
    func getRepositoryList(page: Int, limit: Int) async throws -> DataState<[GgRepositoryEntity]?>
    func getProfile() async throws -> DataState<GgProfileEntity?>
}
