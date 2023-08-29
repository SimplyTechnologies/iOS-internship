
import Foundation

final class ForgotPasswordViewModel: ObservableObject {
  
  @Published var text: String = ""
  @Published var passwordCode: String = ""
  @Published var isCodeGot: Bool = true
  
}
