
import Combine
import Foundation

final class RegisterViewModel: ObservableObject {
  
  @Published var name = TextFieldModel()
  @Published var surname = TextFieldModel()
  @Published var email = TextFieldModel()
  @Published var password = TextFieldModel()
  @Published var repeatedPassword = TextFieldModel()
  
  @Published var isButtonDisabled: Bool = true
  @Published var isLoading: Bool = false
  @Published var hasUserRegistered: Bool = false
  @Published var alertIsPresented: Bool = false
  @Published var toastIsPresented: Bool = false
  @Published var registrationErrorMessage: String = .emptyString
  @Published var registrationSuccessMessage: String = .emptyString
    
  private let storeManager = StoreManager.shared
  private let hapticManager = HapticManager.shared
  private let registerRepository = RegisterRepositoryImpl()
  private var cancellable = Set<AnyCancellable>()
    
  private func setButtonState() {
    if name.text.isEmpty
      || surname.text.isEmpty
      || email.text.isEmpty
      || password.text.isEmpty
      || repeatedPassword.text.isEmpty
        
      || !name.errorMessage.isEmpty
      || !surname.errorMessage.isEmpty
      || !email.errorMessage.isEmpty
      || !password.errorMessage.isEmpty
      || !repeatedPassword.errorMessage.isEmpty {
      isButtonDisabled = true
    } else {
      isButtonDisabled = false
    }
  }
  
  private func check(
    textField: inout TextFieldModel,
    minCharLimit: Int? = nil,
    regexType: Regexes,
    errorMessage: (
      isEmpty: LocalError,
      isShort: LocalError?,
      isInvalid: LocalError
    )
  ) {
    guard !textField.text.isEmpty
    else {
      textField.errorMessage = errorMessage.isEmpty.description
      return
    }
    
    if regexType != .email {
      guard let minCharLimit = minCharLimit,
            textField.text.checkMinimumLength(with: minCharLimit)
      else {
        textField.errorMessage = errorMessage.isShort?.description ?? .emptyString
        return
      }
    }
    
    guard textField.text.isValidWith(regexType: regexType)
    else {
      textField.errorMessage = errorMessage.isInvalid.description
      return
    }
    
    if textField == password {
      checkPasswordMatching()
    }
    
    textField.errorMessage = .emptyString
  }
  
  private func checkPasswordMatching() {
    guard repeatedPassword.text == password.text else {
      repeatedPassword.errorMessage = LocalError.passwordMatch.description
      return
    }

    repeatedPassword.errorMessage = .emptyString
  }
  
  func resetRepeatedPasswordIfNeeded() {
    if password.text != repeatedPassword.text {
      repeatedPassword.text = .emptyString
    }
  }
  
  func registration() {
    registerRepository.signUp(
      payload:
        Api.SignUpInput(
          email: email.text,
          firstName: name.text,
          lastName: surname.text,
          password: password.text
        )
    )
    .receive(on: DispatchQueue.main)
    .sink { [weak self] result in
      guard let self else { return }
      
      switch result {
      case .failure(let error):
        if error.localizedDescription == NetworkError.userExists.description {
          
          storeManager.setValue(
            true, for: UserDefaultsKeys.isFromRegistration.rawValue
          )
          
          storeManager.setValue(email.text, for: UserDefaultsKeys.email.rawValue)
          
          registrationErrorMessage = error.localizedDescription
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hasUserRegistered = true
          }
          
        } else {
          registrationErrorMessage = error.localizedDescription
          hasUserRegistered = false
        }
        
        isLoading = false
        hapticManager.callHaptic(with: .error, and: .medium)
  
      case .finished:
        break
      }
    } receiveValue: { [weak self] _ in
      guard let self else { return }
      
      registrationErrorMessage = .emptyString
      
      storeManager.setValue(
        true, for: UserDefaultsKeys.isFromRegistration.rawValue
      )
      
      storeManager.setValue(email.text, for: UserDefaultsKeys.email.rawValue)
      
      registrationSuccessMessage = ToastTitles.successMessage

      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.hasUserRegistered = true
      }
      
      isLoading = false
      hapticManager.callHaptic(with: .success, and: .medium)
    }
    .store(in: &cancellable)
    
    if hasUserRegistered {
      redirectionIfUserExists()
    } else {
      toastIsPresented = false
    }
  }
  
  func checkTextField(by textField: TextFieldPlaceholder) {
    switch textField {
    case .name:
      name.text = name.text.cutTailIfLimitExceeded(with: 20)
      self.check(
        textField: &name,
        minCharLimit: 2,
        regexType: .name,
        errorMessage: (
          isEmpty: .emptyName,
          isShort: .shortName,
          isInvalid: .invalidName
        )
      )
    case .surname:
      surname.text = surname.text.cutTailIfLimitExceeded(with: 20)
      self.check(
        textField: &surname,
        minCharLimit: 2,
        regexType: .name,
        errorMessage: (
          isEmpty: .emptySurname,
          isShort: .shortSurname,
          isInvalid: .invalidSurname
        )
      )
    case .email:
      email.text = email.text.cutTailIfLimitExceeded(with: 60)
      self.check(
        textField: &email,
        regexType: .email,
        errorMessage: (
          isEmpty: .emptyEmail,
          isShort: .none,
          isInvalid: .invalidEmail
        )
      )
    case .password:
      self.check(
        textField: &password,
        minCharLimit: 8,
        regexType: .password,
        errorMessage: (
          isEmpty: .emptyPassword,
          isShort: .shortPassword,
          isInvalid: .invalidPassword
        )
      )
    case .repeatedPassword:
      checkPasswordMatching()
    }
    
    setButtonState()
  }
  
  func redirectionIfUserExists() {
    toastIsPresented = true

    DispatchQueue.main.asyncAfter(
      deadline: .now() + 3
    ) {
      self.toastIsPresented = false
    }
  }
  
}
