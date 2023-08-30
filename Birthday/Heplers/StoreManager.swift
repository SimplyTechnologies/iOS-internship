
import Foundation

struct StoreManager {
  
  // MARK: - Properties
  static var shared = StoreManager()

  private let userDefaults = UserDefaults.standard

  // MARK: - Initializer
  private init() {}
    
  // MARK: Set
  func setValue(_ value: Any?, for key: String ) {
    userDefaults.setValue(value, forKey: key)
  }
  
  // MARK: Get
  func getObject(for key: String) -> Any? {
    userDefaults.object(forKey: key)
  }

  func getStringObject(for key: String) -> String? {
    userDefaults.string(forKey: key)
  }
  
  func getBoolObject(for key: String) -> Bool {
    userDefaults.bool(forKey: key)
  }
  
  // MARK: Remove
  func removeObject(for key: String) {
    userDefaults.removeObject(forKey: key)
  }
  
}
