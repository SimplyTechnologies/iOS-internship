
import Combine
import Foundation

final class ChangePasswordViewModel: ObservableObject {
  
  @Published var oldPassword = SimpleTextFieldModel()
  @Published var newPassword = SimpleTextFieldModel()
  @Published var repeatNewPassword = SimpleTextFieldModel()
  
  @Published var isLoading: Bool = false
    
  var hasError: Bool = false
  
  private let userRepository: UserRepository
  private var cancellables: Set<AnyCancellable> = []
  
  init(
    userRepository: UserRepository
  ) {
    self.userRepository = userRepository
  }
  
  func changePassword() {
    self.isLoading = true
    userRepository.changePassword(
      oldPassword: oldPassword.text,
      newPassword: newPassword.text
    )
    .receive(on: DispatchQueue.main)
    .sink { [weak self] result in
      self?.isLoading = false
      switch result {
      case .finished: break
      case .failure(let error):
        print(error)
        self?.hasError = true
//        self?.errorMessage = error.localizedDescription
      }
    } receiveValue: { pass in
      print(pass.id)
    }
    .store(in: &cancellables)
  }
  
  func checkOldPassword() {
    guard !oldPassword.text.isEmpty else {
      oldPassword.errorMessage = LocalError.emptyPassword.description
      return
    }
    
    guard oldPassword.text.count >= 8 else {
      oldPassword.errorMessage = LocalError.shortPassword.description
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.password.regex
    )
      .evaluate(with: oldPassword.text)
    else {
      oldPassword.errorMessage = LocalError.invalidPassword.description
      return
    }
    
    checkRepeatedPassword()
    
    oldPassword.errorMessage = .emptyString
  }
  
  func checkNewPassword() {
    guard !newPassword.text.isEmpty else {
      newPassword.errorMessage = LocalError.emptyPassword.description
      return
    }
    
    guard newPassword.text.count >= 8 else {
      newPassword.errorMessage = LocalError.shortPassword.description
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.password.regex
    )
      .evaluate(with: newPassword.text)
    else {
      newPassword.errorMessage = LocalError.invalidPassword.description
      return
    }
    
    checkRepeatedPassword()
    
    newPassword.errorMessage = .emptyString
  }
  
  func checkRepeatedNewPassword() {
    guard !repeatNewPassword.text.isEmpty else {
      repeatNewPassword.errorMessage = LocalError.emptyPassword.description
      return
    }
    
    guard repeatNewPassword.text.count >= 8 else {
      repeatNewPassword.errorMessage = LocalError.shortPassword.description
      return
    }
    
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.password.regex
    )
      .evaluate(with: repeatNewPassword.text)
    else {
      repeatNewPassword.errorMessage = LocalError.invalidPassword.description
      return
    }
    
    checkRepeatedPassword()
    
    repeatNewPassword.errorMessage = .emptyString
  }
  
  func resetRepeatedPasswordIfNeeded() {
    if newPassword.text != repeatNewPassword.text {
      repeatNewPassword.text = .emptyString
    }
  }
  
  private func checkRepeatedPassword() {
    guard repeatNewPassword.text == newPassword.text else {
      repeatNewPassword.errorMessage = LocalError.passwordMatch.description
      return
    }
    repeatNewPassword.errorMessage = .emptyString
  }
  
  private func checkPasswordMatching() {
    guard repeatNewPassword.text == newPassword.text else {
      repeatNewPassword.errorMessage = LocalError.passwordMatch.description
      return
    }

    repeatNewPassword.errorMessage = .emptyString
  }
  
}
