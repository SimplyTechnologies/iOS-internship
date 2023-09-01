
import Combine
import Foundation.NSPredicate

final class SignInViewModel: ObservableObject {
  
  @Published var email = TextFieldModel()
  @Published var password = TextFieldModel()
  
  @Published var isChecked: Bool = false
  
  // Property for set `Sign In` button state
  @Published var isValidationSuccess: Bool = false
  @Published var isDisable: Bool = true
  @Published var isLoading: Bool = false
  
  private let storeManager = StoreManager.shared
  private let accessToken = AccessToken.shared
  private let hapticManager = HapticManager.shared
  private let signInRepository = SignInRepositoryImpl()
  private var cancellables = Set<AnyCancellable>()
  
  var hasError: Bool = false
  
  // Checking email against a regular expression
  private func checkEmailRegex() {
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.email.regex
    )
      .evaluate(with: email.text)
    else {
      email.error = (true, LocalError.invalidEmail.description)
      return
    }
    
    email.error = (false, nil)
  }
  
  func trimCharacterOverflow() {
    let charLimit = 60
    let text = email.text
    
    if text.count > charLimit {
      email.text = String(text.prefix(charLimit))
    }
  }
   
  // Checking password minimum length and against a regular expression
  private func checkPassword() {
    guard password.text.count >= 8 else {
      password.error = (true, LocalError.shortPassword.description)
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.password.regex
    )
      .evaluate(with: password.text)
    else {
      password.error = (true, LocalError.invalidPassword.description)
      return
    }
    
    password.error = (false, nil)
  }
  
  func signIn() {
    signInRepository.signIn(
      payload:
        Api.LoginInput(
          email: email.text,
          password: password.text)
    )
    .receive(on: DispatchQueue.main)
    .sink { [weak self] result in
      guard let self else { return }
      
      switch result {
      case .failure:
        self.hasError = true
        self.isValidationSuccess = false
        self.isLoading = false
        self.hapticManager.callHaptic(with: .error, and: .medium)
      case .finished:
        self.hasError = false
        self.isValidationSuccess = true
        self.isLoading = false
        self.hapticManager.callHaptic(with: .success, and: .medium)
        
        // Saving information that the user has logged
        self.storeManager.setValue(true, for: UserDefaultsKeys.isLogged.rawValue)
        
        // If there is a checkmark, then save the token creation date
        if self.isChecked {
          self.accessToken.saveDate()
        }
      }
    } receiveValue: { [weak self] token in
      guard let self else { return }
      
      // Saving a token for further use in the session
      self.accessToken.save(token: token.access_token)
    }
    .store(in: &cancellables)
  }
  
  func setButton() {
    if email.text.isEmpty
      || password.text.isEmpty
      || email.error.0
      || password.error.0 {
      isDisable = true
    } else {
      isDisable = false
    }
  }
  
  // Getting user's email, if it exists
  func getEmailFromStore() {
    let emailValue = storeManager.getStringObject(
      for: UserDefaultsKeys.email.rawValue
    )
    
    email.text = emailValue
  }
  
  // Checking textfields validation and setting `Sign In` button
  func checkFieldAndSetButton(
    by field: TextFieldPlaceholders
  ) {
    switch field {
    case .email:
      self.checkEmailRegex()
    case .password:
      self.checkPassword()
    default:
      break
    }
    
    self.setButton()
  }
  
}
