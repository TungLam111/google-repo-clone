import Foundation

class CacheLayer {
    private let cache: URLCache
    private let cacheExpirationTime: TimeInterval

    init(memoryCapacity: Int, diskCapacity: Int, cacheExpirationTime: TimeInterval) {
        self.cache = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: "urlCache"
        )
        self.cacheExpirationTime = cacheExpirationTime
    }

    // Retrieve cached data for a given URLRequest
    func getCachedResponse<T: Decodable>(for request: URLRequest) -> T? {
        if let cachedResponse = cache.cachedResponse(for: request) {
            // Check if the cache is expired
            if !isCacheExpired(for: request) {
                if let decodedData = try? JSONDecoder().decode(T.self, from: cachedResponse.data) {
                    return decodedData
                }
            } else {
                // If cache is expired, remove the cached response
                cache.removeCachedResponse(for: request)
            }
        }
        return nil
    }

    // Save data to cache for a given URLRequest
    func saveResponse<T: Encodable>(data: T, for request: URLRequest, response: URLResponse) {
        if let encodedData = try? JSONEncoder().encode(data) {
            let cachedResponse = CachedURLResponse(response: response, data: encodedData)
            cache.storeCachedResponse(cachedResponse, for: request)
            saveCacheTimestamp(for: request)
        }
    }

    // Check if cache is expired for a given URLRequest
    private func isCacheExpired(for request: URLRequest) -> Bool {
        if let lastCacheDate = getCacheTimestamp(for: request) {
            let timeSinceLastCache = Date().timeIntervalSince(lastCacheDate)
            return timeSinceLastCache > cacheExpirationTime
        }
        return true
    }

    // Save the timestamp for when data is cached
    private func saveCacheTimestamp(for request: URLRequest) {
        let cacheKey = cacheKeyForTimestamp(for: request)
        UserDefaults.standard.set(Date(), forKey: cacheKey)
    }

    // Retrieve the cache timestamp
    private func getCacheTimestamp(for request: URLRequest) -> Date? {
        let cacheKey = cacheKeyForTimestamp(for: request)
        return UserDefaults.standard.object(forKey: cacheKey) as? Date
    }

    // Generate a cache key for the timestamp based on the URL
    private func cacheKeyForTimestamp(for request: URLRequest) -> String {
        return "\(request.url?.absoluteString ?? "")_timestamp"
    }
}
