
import Combine
import Foundation

final class NewPasswordViewModel: ObservableObject {
  
  @Published var password = SimpleTextFieldModel()
  @Published var repeatedPassword = SimpleTextFieldModel()
  @Published var isPasswordUpdated = false
  @Published var passwordError: (Bool, message: String?) = (false, message: nil)
  @Published var codeError: (Bool, message: String?) = (false, message: nil)
  @Published var showAlert: Bool = false
  var repeatedPasswordError: (Bool, message: String?) = (false, message: nil)
  private var cancellables: Set<AnyCancellable> = []
  private let signInRepository: SignInRepository
  private let hash: String
  private let email: String
  
  init(
    signInRepository: SignInRepository,
    hash: String,
    email: String
  ) {
    self.signInRepository = signInRepository
    self.hash = hash
    self.email = email
  }
  
  func resetPassword() {
    checkPassword()
    
    signInRepository.resetPassword(
      payload: Api.ResetPasswordInput(
        hash: hash,
        password: password.text,
        email: email
      )
    )
    .receive(on: DispatchQueue.main)
    .sink { [weak self] result in
      switch result {
      case .finished:
        self?.isPasswordUpdated = true
      case .failure(let error):
        // swiftlint:disable:next line_length
        if error.localizedDescription != "Reset Password Hash expired. Please try to reset again." {
          self?.password.errorMessage = error.localizedDescription
          if let errorMessage = self?.passwordError.message {
            self?.password.errorMessage = errorMessage
          }
          if self?.password.text != self?.repeatedPassword.text {
            // swiftlint:disable:next line_length
            self?.repeatedPassword.errorMessage = self?.repeatedPasswordError.message ?? ""
          }
        } else {
          self?.showAlert = true
        }
      }
    } receiveValue: { _ in
    }
    .store(in: &cancellables)
  }
  
  private func checkPassword() {
    guard !password.text.isEmpty else {
      self.passwordError = (
        true,
        LocalError.emptyPassword.description
      )
      return
    }
    guard password.text.count >= 8 else {
      self.passwordError = (
        true,
        LocalError.shortPassword.description
      )
      return
    }
    guard NSPredicate(
      format: Regexes.matchFormat,
      Regexes.password.regex
    )
      .evaluate(with: password.text)
    else {
      self.passwordError = (
        true,
        LocalError.invalidPassword.description
      )
      return
    }
    checkRepeatedPassword()
    self.passwordError = (false, nil)
  }
  
  private func checkRepeatedPassword() {
    guard repeatedPassword.text == password.text else {
      self.repeatedPasswordError = (
        true,
        LocalError.passwordMatch.description
      )
      return
    }
    self.repeatedPasswordError = (false, nil)
  }
  
}
