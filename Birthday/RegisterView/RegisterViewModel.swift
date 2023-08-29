
import Foundation

final class RegisterViewModel: ObservableObject {
  
  // MARK: - Properties
  @Published var name = RegisterTextFieldModel()
  @Published var surname = RegisterTextFieldModel()
  @Published var email = RegisterTextFieldModel()
  @Published var password = RegisterTextFieldModel()
  @Published var repeatPassword = RegisterTextFieldModel()
  
  @Published var isDisable: Bool = true
  
  // MARK: - Functions
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
        || repeatPassword.error.0
    {
      isDisable = true
    }
    else {
      isDisable = false
    }
  }
  
  // MARK: Name
  private func checkName() {
    guard !name.text.isEmpty else {
      name.error = (true, LocalError.emptyName.description)
      return
    }
    
    guard name.text.count >= 2 else {
      name.error = (true, LocalError.shortName.description)
      return
    }
    
    guard NSPredicate(format: Regexes.matchFormat, Regexes.name.regex).evaluate(with: name.text) else {
      name.error = (true, LocalError.invalidName.description)
      return
    }
    
    name.error = (false, nil)
  }
  
  // MARK: Surname
  private func checkSurname() {
    guard !surname.text.isEmpty else {
      surname.error = (true, LocalError.emptySurname.description)
      return
    }
    
    guard surname.text.count >= 2 else {
      surname.error = (true, LocalError.shortSurname.description)
      return
    }
    
    guard NSPredicate(format: Regexes.matchFormat, Regexes.name.regex).evaluate(with: surname.text) else {
      surname.error = (true, LocalError.invalidSurname.description)
      return
    }
    
    surname.error = (false, nil)
  }
  
  // MARK: Email
  private func checkEmail() {
    guard !email.text.isEmpty else {
      email.error = (true, LocalError.emptyEmail.description)
      return
    }
    
    guard NSPredicate(format: Regexes.matchFormat, Regexes.email.regex).evaluate(with: email.text) else {
      email.error = (true, LocalError.invalidEmail.description)
      return
    }
    
    email.error = (false, nil)
  }
  
  // MARK: Password
  private func checkPassword() {
    guard !password.text.isEmpty else {
      password.error = (true, LocalError.emptyPassword.description)
      return
    }
    
    guard password.text.count >= 8 else {
      password.error = (true, LocalError.shortPassword.description)
      return
    }
    
    // If password was edited
    checkRepeatedPassword()
    
    password.error = (false, nil)
  }
  
  // MARK: Repeated password
  private func checkRepeatedPassword() {
    guard repeatPassword.text == password.text else {
      repeatPassword.error = (true, LocalError.passwordMatch.description)
      return
    }

    repeatPassword.error = (false, nil)
  }
  
  // MARK: Check field by name
  func checkTextField(by field: TextFieldPlaceholders) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      guard let self else { return }
      
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
  }
}
