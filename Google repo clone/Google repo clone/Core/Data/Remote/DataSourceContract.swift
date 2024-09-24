import Foundation

protocol DataSourceRemoteContract {
    func getAuthorizationStorage() -> AuthenticationLocalStorage;
}

extension DataSourceRemoteContract {
    func formHeaders(customHeaders: [String: String]?) -> [String: String]? {
        var headers: [String: String] = ["Content-Type": "application/json"]
        customHeaders?.forEach { (key: String, value: String) in
            headers[key] = value;
        }
        
        let authHeaders = authorizationHeaders()
        authHeaders?.forEach { (key: String, value: String) in
            headers[key] = value;
        }
        return headers;
    }
}

extension DataSourceRemoteContract {
    func authorizationHeaders() -> [String: String]?  {
        let accessToken: String? = getAuthorizationStorage().getAccessToken()
        var customHeaders: [String: String] = [:]
        if accessToken != nil && !accessToken!.isEmpty {
            customHeaders["Authorization"] = "token \(accessToken ?? "")"
        }
        return customHeaders;
    }
}
