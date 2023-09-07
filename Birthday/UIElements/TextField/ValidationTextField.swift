
import SwiftUI

struct ValidationTextField: View {
  
  @Binding var isPasswordHidden: Bool

  private let placeholder: String
  private let text: Binding<String>
  private let errorMessage: String
  private let isAutocapitalization: Bool
  private let submitLabel: SubmitLabel
  private var isSecure: Bool
  
  init(
    placeholder: String,
    text: Binding<String>,
    errorMessage: String,
    isAutocapitalization: Bool = true,
    isSecure: Bool = false,
    isPasswordHidden: Binding<Bool>,
    submitLabel: SubmitLabel = .next
  ) {
    self.placeholder = placeholder
    self.text = text
    self.errorMessage = errorMessage
    self.isAutocapitalization = isAutocapitalization
    self.isSecure = isSecure
    self._isPasswordHidden = isPasswordHidden
    self.submitLabel = submitLabel
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        if isPasswordHidden && isSecure {
          SecureField(placeholder, text: text)
            .textFieldStyle(
              ValidationTextFieldStyle(
                isAutocapitalization: false,
                submitLabel: submitLabel
              )
            )
            
        } else {
          TextField(placeholder, text: text)
            .textFieldStyle(
              ValidationTextFieldStyle(
                isAutocapitalization: isAutocapitalization && !isSecure,
                submitLabel: submitLabel
              )
            )
        }
        
        // MARK: Open-closed eye image
        if isSecure {
          Button {
            isPasswordHidden.toggle()
          } label: {
            isPasswordHidden
            ? Image(Images.hidePassword.rawValue)
            : Image(Images.seePassword.rawValue)
          }
          .padding(.trailing, 12)
        }
      }
      .background(
        errorMessage.isEmpty ? Color.backgroundColor : Color.errorBackgroundColor
      )
      .cornerRadius(13)
      .overlay {
        if !errorMessage.isEmpty {
          RoundedCornersRectangle(
            corners: .allCorners,
            radius: 13
          )
          .stroke(
            Color.errorColor,
            lineWidth: 1
          )
        }
      }
      
      ErrorMessageText(errorMessage)
    }
    .animation(.easeInOut, value: errorMessage)
  }
  
}
