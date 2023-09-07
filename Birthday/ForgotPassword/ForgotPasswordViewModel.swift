
import Combine
import Foundation

final class ForgotPasswordViewModel: ObservableObject {
  
  @Published var email = SimpleTextFieldModel()
  @Published var hasError: (Bool, message: String?) = (false, nil)
  @Published var passwordCode: String = ""
  @Published var isCodeGot: Bool = false
  @Published var isDisable: Bool = true
  @Published var navigateToResetPassword: Bool = false
  @Published var isLoading: Bool = false
  @Published var toasts: [Toast] = []
  @Published var isVerificationCodeViewVisible = false
  @Published var codeText = ""
  @Published var isPasswordHidden = true
  
  var isCodeMatched: Bool {
    codeText == passwordCode
  }
  
  private var cancellables: Set<AnyCancellable> = []
  private var verificationCode: String?
  private let signInRepository: SignInRepository
  
  init(signInRepository: SignInRepository) {
    self.signInRepository = signInRepository
  }
  
  func getVerificationCode() {
    signInRepository.resetPasswordEmail(email: email.text)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished:
          self?.isVerificationCodeViewVisible = true
        case .failure(let error):
          print(error)
          self?.email.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] _ in
        self?.isCodeGot = true
      }
      .store(in: &cancellables)
  }
  
  func checkAndSetButton() {
    hasError = (false, nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      if !self.validateEmail() {
        self.hasError = (true, "Invalid email format")
      } else {
        self.isVerificationCodeViewVisible = true
        self.setButton()
      }
    }
  }
  
  func showToast(message: String) {
    let toast = Toast(
      message: message,
      isSuccess: true
    )
    toasts.append(toast)
    DispatchQueue.main.asyncAfter(
      deadline: .now() + toast.duration
    ) {
      if let index = self.toasts.firstIndex(
        where: { $0 == toast }) {
        self.toasts.remove(at: index)
      }
    }
  }
  
  func validateEmail() -> Bool {
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email.text)
  }
  
  private func setButton() {
    isDisable = !validateEmail() || email.text.isEmpty
  }
  
}
