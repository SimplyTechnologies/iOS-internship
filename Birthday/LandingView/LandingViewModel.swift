
import Combine
import Foundation

final class LandingViewModel: ObservableObject {
  
  @Published var isLoggedInOnce = false

  private let storeManager = StoreManager.shared

  init() {
    checkIfUserIsLogged()
  }
  
  func checkIfUserIsLogged() {
    isLoggedInOnce = storeManager.getBoolObject(
      for: UserDefaultsKeys.isLoggedInOnce.rawValue
    )
  }
  
}
