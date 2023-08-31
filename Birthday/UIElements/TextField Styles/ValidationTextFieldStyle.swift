
import SwiftUI

struct ValidationTextFieldStyle: TextFieldStyle {
  
  // MARK: - Properties
  private var isError: Bool
  private var isAutocapitalization: Bool
  
  // MARK: - Initializer
  init(isError: Bool = false, isAutocapitalization: Bool) {
    self.isError = isError
    self.isAutocapitalization = isAutocapitalization
  }
  
  // MARK: - Functions
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .font(Font.custom(weight: .regular, size: 14))
      .foregroundColor(Color.primaryColor).opacity(0.74)
      .padding(.leading, 20)
      .autocorrectionDisabled()
      .textInputAutocapitalization(isAutocapitalization ? .words : .never)
      .frame(height: 41)
  }
  
}
