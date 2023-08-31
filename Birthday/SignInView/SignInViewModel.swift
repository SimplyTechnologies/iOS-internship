
import Combine
import SwiftUI

final class SignInViewModel: ObservableObject {
  
  // MARK: - Properties
  @Published var email = SignInTextFieldModel()
  @Published var password = SignInTextFieldModel()
  
  @Published var isDisable: Bool = true
  @Published var isChecked: Bool = false
  
  #warning("Переименовать свойство")
  // Property for set `Sign In` button state
  @Published var isValidationSuccess: Bool = false
  
  private let storeManager = StoreManager.shared
  private let accessToken = AccessToken.shared
  private let signInRepository = SignInRepositoryImpl()
  private var cancellables = Set<AnyCancellable>()
  
  var errorMessage: String = ""
  var hasError: Bool = false
  
  // MARK: - Functions
  // Checking email against a regular expression
  private func checkEmailRegex() {
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.email.regex
    )
      .evaluate(with: email.text)
    else {
      withAnimation(.easeIn(duration: 0.3)) {
        email.error = (true, LocalError.invalidEmail.description)
      }
      return
    }
    
    email.error = (false, nil)
  }
  
  // Checking email maximum length
  func checkEmailLength() {
    let charLimit = 60
    let text = email.text

    if text.count > charLimit {
      email.text = String(text.prefix(charLimit))
    }
  }
  
  // Checking password minimum length
  private func checkPasswordLength() {
    guard password.text.count >= 8 else {
      withAnimation(.easeIn(duration: 0.3)) {
        password.error = (true, LocalError.shortPassword.description)
      }
      return
    }
    
    password.error = (false, nil)
  }
  
//  func signIn() {
//    signInRepository.signIn(
//      payload:
//        Api.LoginInput(
//          email: email.text,
//          password: password.text)
//    )
//    .receive(on: DispatchQueue.main)
//    .sink { [weak self] result in
//      switch result {
//      case .failure:
//        guard let self else { return }
//        self.isValidationSuccess = false
//        self.hasError = true
//        self.errorMessage = NetworkError.validationFailure.description
//      case .finished:
//        break
//      }
//    } receiveValue: { [weak self] token in
//      guard let self else { return }
//      
//      self.isValidationSuccess = true
//      self.hasError = false
//      self.errorMessage = ""
//      
//      // Saving a token for further use in the session
//      accessToken.save(token: token.access_token)
//      print(isChecked)
//      // If there is a checkmark, then save the token creation date
//      if isChecked {
//        accessToken.saveDate()
//        
//        // Resave the email, because after registering the user may be logged into another account
//        storeManager.setValue(email.text, for: SignInKeys.email.rawValue)
//        
//        // Saving information that the user has logged
//        storeManager.setValue(true, for: SignInKeys.isLogged.rawValue)
//      }
//    }
//    .store(in: &cancellables)
//  }
  
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
    if let emailValue = storeManager.getStringObject(for: SignInKeys.email.rawValue) {
      email.text = emailValue
    }
  }

  // Checking textfields validation and setting `Sign In` button
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
