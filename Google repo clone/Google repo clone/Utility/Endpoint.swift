import Foundation

class NetworkUrlConstant {
    static let profilePath : String = "orgs/google";
    static let repoPath : String = "orgs/google/repos";

    static func replaceId(path: String, id: String) -> String {
        return path.replacingOccurrences(of: "id", with: id);
    }
}

struct CustomEndpoint {
    var path: String
    var headers: [String: String]? = ["Content-type": "application/json"]
    var queries: [String: String] = [:];
    
    init(path: String, headers: [String: String]?, queries: [String: String]?) {
        self.path = path
        self.queries = queries ?? [:]
        self.headers = headers;
    }
}

extension CustomEndpoint {
        var url: URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            components.path = (path.hasPrefix("/") ? path : "/" + path)
            components.queryItems = self.queries.map { URLQueryItem(name: $0.key, value: $0.value) }
            
    
            guard let url = components.url else {
                preconditionFailure("Invalid URL components: \(components)")
            }
    
            return url
        }
    
    var urlMain: URL {
        var components = URLComponents()
        
        components.scheme = "http"
        components.host = "localhost"
        components.port = 3000
        components.path = (path.hasPrefix("/") ? path : "/" + path)
        components.queryItems = self.queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url;
    }
}
