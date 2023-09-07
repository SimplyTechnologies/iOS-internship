
import SwiftUI

struct SimpleTextFieldStyle: TextFieldStyle {
  
  private var isAutocapitalization: Bool
  
  init(
    isAutocapitalization: Bool
  ) {
    self.isAutocapitalization = isAutocapitalization
  }
  
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .foregroundColor(
        Color.primaryColor.opacity(0.7)
      )
      .font(
        Font.custom(weight: .bold, size: 14)
      )
      .padding(.leading, 20)
      .autocorrectionDisabled()
      .frame(height: 41)
      .textInputAutocapitalization(isAutocapitalization ? .words : .never)
      .cornerRadius(66)
  }
}
