
import Foundation
import Combine

final class MainViewModel: ObservableObject {
  
  static var LoginStatusSubject = PassthroughSubject<Bool, Never>()

  @Published var isLogged = false
  private let storeManager = StoreManager.shared
  private var LoginStatusPublisher: AnyPublisher<Bool, Never> = {
    LoginStatusSubject.eraseToAnyPublisher()
  }()
  private var cancellable = Set<AnyCancellable>()
  
  init() {
    isTokenExists()
    LoginStatusPublisher.sink { isLogin in
      self.isLogged = isLogin
    }
    .store(in: &cancellable)
  }
  
  func isTokenExists() {
    guard let tokenCreateDate =
      storeManager.getObject(
        for: UserDefaultsKeys.tokenCreationDate.rawValue
      ) as? Date
    else {
      isLogged = false
      return
    }
    
    let currentDate = Date()
    let numberOfDays = Calendar(identifier: .gregorian)
      .numberOfDaysBetween(tokenCreateDate, and: currentDate)
    
    if numberOfDays <= 90 {
      isLogged = true
    } else {
      storeManager.removeObject(for: UserDefaultsKeys.token.rawValue)
      storeManager.removeObject(for: UserDefaultsKeys.tokenCreationDate.rawValue)
      isLogged = false
    }
  }
  
}
