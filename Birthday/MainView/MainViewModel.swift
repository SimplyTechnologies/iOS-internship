
import Combine
import Foundation

final class MainViewModel: ObservableObject {
  
  static var loginStatusSubject = PassthroughSubject<Bool, Never>()

  @Published var isAuthorized = false
  
  private let storeManager = StoreManager.shared
  private var loginStatusPublisher: AnyPublisher<Bool, Never> = {
    loginStatusSubject.eraseToAnyPublisher()
  }()
  private var cancellable = Set<AnyCancellable>()
  
  init() {
    isTokenExists()
    
    loginStatusPublisher.sink { isLogin in
      self.isAuthorized = isLogin
    }
    .store(in: &cancellable)
  }
  
  func isTokenExists() {
    guard let tokenCreateDate =
      storeManager.getObject(
        for: UserDefaultsKeys.tokenCreationDate.rawValue
      ) as? Date
    else {
      isAuthorized = false
      return
    }
    
    let currentDate = Date()
    let numberOfDays = Calendar(identifier: .gregorian)
      .numberOfDaysBetween(tokenCreateDate, and: currentDate)
    
    if numberOfDays <= 90 {
      isAuthorized = true
    } else {
      storeManager.removeObject(for: UserDefaultsKeys.token.rawValue)
      storeManager.removeObject(for: UserDefaultsKeys.tokenCreationDate.rawValue)
      isAuthorized = false
    }
  }
  
}
