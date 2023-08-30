
import Foundation

struct AccessToken {
  
  static var shared = AccessToken()
  
  private let storeManager = StoreManager.shared
  
  private init() {}
  
  func save(token: String) {
    storeManager.setValue(token, for: SignInKeys.token.rawValue)
  }
  
  func saveDate() {
    let currentDate = Date()
    storeManager.setValue(
      currentDate,
      for: SignInKeys.tokenCreationDate.rawValue
    )
  }
  
}
