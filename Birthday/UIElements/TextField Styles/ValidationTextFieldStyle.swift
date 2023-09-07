
import SwiftUI

struct ValidationTextFieldStyle: TextFieldStyle {
  
  private var isAutocapitalization: Bool
  private let submitLabel: SubmitLabel
  
  init(
    isAutocapitalization: Bool,
    submitLabel: SubmitLabel = .next
  ) {
    self.isAutocapitalization = isAutocapitalization
    self.submitLabel = submitLabel
  }
  
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .font(Font.custom(weight: .regular, size: 14))
      .foregroundColor(Color.primaryColor).opacity(0.74)
      .padding(.leading, 20)
      .autocorrectionDisabled()
      .textInputAutocapitalization(isAutocapitalization ? .words : .never)
      .frame(height: 41)
      .submitLabel(submitLabel)
  }
  
}
