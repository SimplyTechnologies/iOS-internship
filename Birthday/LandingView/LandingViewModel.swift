
import Foundation

final class LandingViewModel: ObservableObject {
  
  @Published var isAlreadyLogged = false
  private let storeManager = StoreManager.shared
  
  init() {
    checkIfUserIsLogged()
  }
  
  func checkIfUserIsLogged() {
    isAlreadyLogged = storeManager.getBoolObject(
      for: UserDefaultsKeys.isLogged.rawValue
    )
  }
  
}
