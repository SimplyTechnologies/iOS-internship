
import Foundation

final class RegisterViewModel: ObservableObject {
  
  @Published var name = TextFieldModel()
  @Published var surname = TextFieldModel()
  @Published var email = TextFieldModel()
  @Published var password = TextFieldModel()
  @Published var repeatPassword = TextFieldModel()
  
  @Published var isDisable: Bool = true
  @Published var isLoading: Bool = true
  @Published var hasRegistrationError: Bool = false
  @Published var toastIsHidden: Bool = true
  
  var testToggle: Bool = false // TODO: УБРАТЬ!!!!!!!!!!!
  
  private let storeManager = StoreManager.shared
  let toast = Toast(
    message: ToastTitles.successMessage,
    isSuccess: true
  )
  
  private func checkName() {
    guard !name.text.isEmpty else {
      name.error = (true, LocalError.emptyName.description)
      return
    }
    
    guard name.text.count >= 2 else {
      name.error = (true, LocalError.shortName.description)
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.name.regex
    )
      .evaluate(with: name.text)
    else {
      name.error = (true, LocalError.invalidName.description)
      return
    }
    
    name.error = (false, nil)
  }
  
  private func checkSurname() {
    guard !surname.text.isEmpty else {
      surname.error = (true, LocalError.emptySurname.description)
      return
    }
    
    guard surname.text.count >= 2 else {
      surname.error = (true, LocalError.shortSurname.description)
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.name.regex
    )
      .evaluate(with: surname.text)
    else {
      surname.error = (true, LocalError.invalidSurname.description)
      return
    }
    
    surname.error = (false, nil)
  }
  
  private func checkEmail() {
    guard !email.text.isEmpty else {
      email.error = (true, LocalError.emptyEmail.description)
      return
    }
    
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
  
  private func checkPassword() {
    guard !password.text.isEmpty else {
      password.error = (true, LocalError.emptyPassword.description)
      return
    }
    
    guard password.text.count >= 8 else {
      password.error = (true, LocalError.shortPassword.description)
      return
    }
    
//    guard NSPredicate(
//      format: Regexes.matchFormat,
//      Regexes.password.regex
//    )
//      .evaluate(with: password.text)
//    else {
//      completion(true, LocalError.invalidPassword.description)
//      return
//    }
    
    // If password was edited
    checkRepeatedPassword()
    
    password.error = (false, nil)
  }
  
  private func checkRepeatedPassword() {
    guard repeatPassword.text == password.text else {
      repeatPassword.error = (true, LocalError.passwordMatch.description)
      return
    }
    
    repeatPassword.error = (false, nil)
  }
  
  private func saveUserEmail() {
    storeManager.setValue(email.text.lowercased(), for: UserDefaultsKeys.email.rawValue)
  }
  
  func registration() {
    // get response
    
    testToggle.toggle()
    
    if testToggle {
      showToast()
      saveUserEmail()
    } else {
      toastIsHidden = true
    }
    
  }
  
  func setButtonState() {
    if name.text.isEmpty
      || surname.text.isEmpty
      || email.text.isEmpty
      || password.text.isEmpty
      || repeatPassword.text.isEmpty
        
      || name.error.0
      || surname.error.0
      || email.error.0
      || password.error.0
      || repeatPassword.error.0 {
      isDisable = true
    } else {
      isDisable = false
    }
  }
  
  func checkTextField(by field: TextFieldPlaceholders) {
      switch field {
      case .name:
        self.checkName()
      case .surname:
        self.checkSurname()
      case .email:
        self.checkEmail()
      case .password:
        self.checkPassword()
      case .repeatPassword:
        self.checkRepeatedPassword()
      }
      
      setButtonState()
  }
  
  // Checking email maximum length
  func checkLength(by field: TextFieldPlaceholders) {
    let charLimit: Int
    
    switch field {
    case .name:
      charLimit = 20
      if name.text.count > charLimit {
        name.text = String(name.text.prefix(charLimit))
      }
    case .surname:
      charLimit = 20
      if surname.text.count > charLimit {
        surname.text = String(surname.text.prefix(charLimit))
      }
    case .email:
      charLimit = 60
      if email.text.count > charLimit {
        email.text = String(email.text.prefix(charLimit))
      }
    default:
      break
    }
  }
  
  func showToast() {
    toastIsHidden = false
    
    DispatchQueue.main.asyncAfter(
      deadline: .now() + 3
    ) { [weak self] in
      guard let self else { return }
        self.toastIsHidden = true
    }
  }
  
}
