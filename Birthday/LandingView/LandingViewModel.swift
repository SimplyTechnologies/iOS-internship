
import Combine
import Foundation

final class LandingViewModel: ObservableObject {
  
  @Published var isLoggedInOnce = false
//  @Published var fromRegToSign = false

  private let storeManager = StoreManager.shared
  
//  private var stateFromRegisterPublisher: AnyPublisher<Bool, Never> = {
//    stateFromRegisterSubject.eraseToAnyPublisher()
//  }()
    
  init() {
//    stateFromRegisterPublisher.sink { isLogged in
//      self.fromRegToSign = isLogged
//    }
    
    checkIfUserIsLogged()
    print("isLoggedInOnce: ", isLoggedInOnce)
  }
  
  func checkIfUserIsLogged() {
    isLoggedInOnce = storeManager.getBoolObject(
      for: UserDefaultsKeys.isLoggedInOnce.rawValue
    )
    
  }
  
}
