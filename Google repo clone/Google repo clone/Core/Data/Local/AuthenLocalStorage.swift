
import Foundation

class AuthenticationLocalStorage {
    private let defaults : UserDefaults;
    private var refreshTokenService : SimpleLocalStorage<String>;
    private var accessTokenService : SimpleLocalStorage<String>;
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
        self.refreshTokenService = SimpleLocalStorage(sharedPrefs: self.defaults, keyObj: "refresh_token")
        self.accessTokenService = SimpleLocalStorage(sharedPrefs: self.defaults, keyObj: "access_token")
    }
    
    func getAccessToken() -> String? {
        return self.accessTokenService.load()
    }
    
    func getRefreshToken() -> String? {
        return self.refreshTokenService.load()
    }
    
    func saveAccessToken(token: String) -> Bool {
        return self.accessTokenService.save(token)
    }
    
    func saveRefreshToken(token: String) -> Bool {
        return self.refreshTokenService.save(token)
    }
}
