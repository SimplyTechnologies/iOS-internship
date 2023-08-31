
import Foundation

final class MainViewModel: ObservableObject {
  
  private let storeManager = StoreManager.shared
  
  func isTokenExist() -> Bool {
    guard let tokenCreateDate =
      storeManager.getObject(
        for: SignInKeys.tokenCreationDate.rawValue
      ) as? Date
    else { return false }
    
    let currentDate = Date()
    let numberOfDays = Calendar(identifier: .gregorian)
      .numberOfDaysBetween(tokenCreateDate, and: currentDate)
    
    if numberOfDays <= 90 {
      return true
    } else {
      storeManager.removeObject(for: SignInKeys.token.rawValue)
      storeManager.removeObject(for: SignInKeys.tokenCreationDate.rawValue)
      return false
    }
  }
  
}
