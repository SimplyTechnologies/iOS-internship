
import Combine
import Foundation.NSPredicate

final class SignInViewModel: ObservableObject {
    
  @Published var email = TextFieldModel()
  @Published var password = TextFieldModel()
  
  @Published var isCheckboxChecked: Bool = false
  @Published var hasUserLoggedIn: Bool = false
  @Published var isButtonDisabled: Bool = true
  @Published var isLoading: Bool = false
  @Published var hasError: Bool = false
    
  private let storeManager = StoreManager.shared
  private let accessToken = AccessToken.shared
  private let hapticManager = HapticManager.shared
  
  private let signInRepository = SignInRepositoryImpl()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    presetEmailTextField()
  }
  
  private func presetEmailTextField() {
    email.text = storeManager.getStringObject(for: UserDefaultsKeys.email.rawValue)
    storeManager.removeObject(for: UserDefaultsKeys.email.rawValue)
  }
  
  private func checkEmail() {
    guard !email.text.isEmpty else {
      email.errorMessage = LocalError.emptyEmail.description
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.email.regex
    )
      .evaluate(with: email.text)
    else {
      email.errorMessage = LocalError.invalidEmail.description
      return
    }
    
    email.errorMessage = .emptyString
  }
  
  func trimCharacterOverflow() {
    let charLimit = 60
    let text = email.text

    if text.count > charLimit {
      email.text = String(text.prefix(charLimit))
    }
  }
   
  private func checkPassword() {
    guard !password.text.isEmpty else {
      password.errorMessage = LocalError.emptyPassword.description
      return
    }
    
    guard password.text.count >= 8 else {
      password.errorMessage = LocalError.shortPassword.description
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.password.regex
    )
      .evaluate(with: password.text)
    else {
      password.errorMessage = LocalError.invalidPassword.description
      return
    }
    
    password.errorMessage = .emptyString
  }
  
  func signIn() {
    signInRepository.signIn(
      payload:
        Api.LoginInput(
          email: email.text,
          password: password.text
        )
    )
    .receive(on: DispatchQueue.main)
    .sink { [weak self] result in
      guard let self else { return }
      
      switch result {
      case .failure:
        hasError = true
        hasUserLoggedIn = false
        isLoading = false
        hapticManager.callHaptic(with: .error, and: .medium)
      case .finished:
        hasError = false
        
        // Saving information that the user has logged
        storeManager.setValue(true, for: UserDefaultsKeys.isLoggedInOnce.rawValue)
        
        // If there is a checkmark, then save the token creation date
        if isCheckboxChecked {
          accessToken.saveDate()
        }
        
        hapticManager.callHaptic(with: .success, and: .medium)
        hasUserLoggedIn = true
        isLoading = false
      }
    } receiveValue: { [weak self] token in
      guard let self else { return }
      
      // Saving a token for further use in the session
      accessToken.save(token: token.access_token)
      MainViewModel.loginStatusSubject.send(true)
    }
    .store(in: &cancellables)
  }
  
  func setButton() {
    if email.text.isEmpty
      || password.text.isEmpty
        
      || !email.errorMessage.isEmpty
      || !password.errorMessage.isEmpty {
      isButtonDisabled = true
    } else {
      isButtonDisabled = false
    }
  }

  func checkTextFieldAndSetButton(
    by textField: TextFieldPlaceholder
  ) {
    switch textField {
    case .email:
      self.checkEmail()
    case .password:
      self.checkPassword()
    default:
      break
    }
    
    self.setButton()
  }
  
}
