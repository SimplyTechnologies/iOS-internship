
import Combine
import Foundation

final class LandingViewModel: ObservableObject {
  
  @Published var isLoggedInOnce = false
  
  private let storeManager = StoreManager.shared

  init() {
    checkIsUserLoggedInOnce()
    
    if !isLoggedInOnce {
      checkIsFromRegistration()
      storeManager.removeObject(for: UserDefaultsKeys.isFromRegistration.rawValue)
    }
  }
  
  private func checkIsUserLoggedInOnce() {
    isLoggedInOnce = storeManager.getBoolObject(
      for: UserDefaultsKeys.isLoggedInOnce.rawValue
    )
  }
  
  private func checkIsFromRegistration() {
    isLoggedInOnce = storeManager.getBoolObject(for: UserDefaultsKeys.isFromRegistration.rawValue)
  }
  
}
