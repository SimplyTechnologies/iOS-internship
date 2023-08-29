
import Combine
import SwiftUI

final class SignInViewModel: ObservableObject {
  
  // MARK: - Properties
  @Published var email = SignInTextFieldModel()
  @Published var password = SignInTextFieldModel()
  
  @Published var isDisable: Bool = true
  @Published var isChecked: Bool = false
  
  @Published var isValidationSuccess: Bool = false // property for set `Sign In` button state
  
  private let userDefaults = UserDefaults.standard
  private let signInRepository = SignInRepositoryImpl()
  private var cancellables = Set<AnyCancellable>()
  
  var errorMessage: String = ""
  var hasError: Bool = false
  
  // MARK: - Functions
  
  /// Saving user's email in UserDefaults for textField autofilling, if user back to Sign In screen
  private func rememberUser(email: String) {
    userDefaults.set(isChecked, forKey: SignInKeys.isChecked.rawValue)
    userDefaults.set(email, forKey: SignInKeys.email.rawValue)
  }
  
  /// Removing user's data from UserDefaults
  private func forgetUser() {
    userDefaults.removeObject(forKey: SignInKeys.isChecked.rawValue)
    userDefaults.removeObject(forKey: SignInKeys.email.rawValue)
  }
  
  /// Saving an access token in UserDefaults
  private func saveToken(token: String) {
    userDefaults.set(token, forKey: SignInKeys.token.rawValue)
  }
  
  // MARK: Authorization
  func signIn() {
    signInRepository.signIn(
      payload:
        Api.LoginInput(
          email: email.text,
          password: password.text)
    )
    .receive(on: DispatchQueue.main)
    .sink { [weak self] result in
      switch result {
      case .failure(_):
        guard let self else { return }
        self.isValidationSuccess = false
        self.hasError = true
        self.errorMessage = NetworkError.validationFailure.description
      case .finished:
        break
      }
    } receiveValue: { [weak self] token in
      guard let self else { return }
      self.saveToken(token: token.access_token)
      self.isValidationSuccess = true
      self.hasError = false
      self.errorMessage = ""
      self.userDefaults.setValue(Date(), forKey: SignInKeys.tokenCreationDate.rawValue)
    }
    .store(in: &cancellables)
  }
  
  // MARK: Set button state
  func setButton() {
    if email.text.isEmpty
        || password.text.isEmpty
        || email.error.0
        || password.error.0
    {
      isDisable = true
    } else {
      isDisable = false
    }
  }
  
  // MARK: Check email regex
  func checkEmailRegex() {
    guard NSPredicate(format: Regexes.matchFormat, Regexes.email.regex).evaluate(with: email.text) else {
      withAnimation(.easeIn(duration: 0.3)) {
        email.error = (true, LocalError.invalidEmail.description)
      }
      return
    }
    
    email.error = (false, nil)
  }
  
  // MARK: Check password minimum length
  func checkPasswordLength() {
    guard password.text.count >= 8 else {
      withAnimation(.easeIn(duration: 0.3)) {
        password.error = (true, LocalError.shortPassword.description)
      }
      return
    }
    
    password.error = (false, nil)
  }
  
  /// Getting user's data, if it exists
  func getDataFromStore() {
    let isCheckedValue = userDefaults.bool(forKey: SignInKeys.isChecked.rawValue)
    isChecked = isCheckedValue
    
    if isChecked,
       let emailValue = userDefaults.string(forKey: SignInKeys.email.rawValue) {
      email.text = emailValue
    }
  }
  
  /// Save or remove user's data from UserDefaults
  func setIfIsChecked() {
    isChecked ? rememberUser(email: email.text) : forgetUser()
  }
  
  /// Checking textfields validation and setting `Sign In` button
  func checkAndSetButton(by field: TextFieldPlaceholders) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      switch field {
      case .email:
        self.checkEmailRegex()
      case .password:
        self.checkPasswordLength()
      default:
        break
      }
      
      self.setButton()
    }
  }

}
