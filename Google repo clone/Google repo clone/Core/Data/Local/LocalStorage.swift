import Foundation
import UIKit

protocol LocalStorage {
    associatedtype T: Codable
    func _save(_ value: [T]) -> Bool
    func saveOne(_ value: T) -> Bool
    func load() -> [T]?
    func removeOne(by item: T) -> Bool
    func remove() -> Bool
}

class SimpleLocalStorage<T: Codable> {
    
    private let defaults : UserDefaults;

    private var keyObj: String;
    
    init(sharedPrefs: UserDefaults, keyObj: String) {
        self.keyObj = keyObj
        self.defaults = UserDefaults.standard

    }
    
    func save(_ value: T) -> Bool {
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: self.keyObj)
            return true;
        }
        return false;
    }
    
    func load() -> T? {
        if let data = defaults.data(forKey: self.keyObj),
           let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
        return nil;
    }
    
    func remove() -> Bool {
        defaults.removeObject(forKey: self.keyObj)
        return true
    }
}
