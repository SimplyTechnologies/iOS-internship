
import Foundation

final class MainViewModel: ObservableObject {
  
  private let storeManager = StoreManager.shared
  
  func isTokenExists() -> Bool {
    guard let tokenCreateDate =
      storeManager.getObject(
        for: UserDefaultsKeys.tokenCreationDate.rawValue
      ) as? Date
    else { return false }
    
    let currentDate = Date()
    let numberOfDays = Calendar(identifier: .gregorian)
      .numberOfDaysBetween(tokenCreateDate, and: currentDate)
    
    if numberOfDays <= 90 {
      return true
    } else {
      storeManager.removeObject(for: UserDefaultsKeys.token.rawValue)
      storeManager.removeObject(for: UserDefaultsKeys.tokenCreationDate.rawValue)
      return false
    }
  }
  
}
