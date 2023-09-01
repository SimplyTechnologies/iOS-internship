
import SwiftUI

struct ValidationTextField: View {
  
  @State private var isPasswordHidden: Bool = true
  private let placeholder: String
  private let text: Binding<String>
  private let hasError: Binding<(Bool, message: String?)>
  private let isAutocapitalization: Bool
  private var isSecure: Bool
  
  init(
    placeholder: String,
    text: Binding<String>,
    hasError: Binding<(Bool, message: String?)>,
    isSecure: Bool = false,
    isAutocapitalization: Bool = true
  ) {
    self.placeholder = placeholder
    self.text = text
    self.hasError = hasError
    self.isSecure = isSecure
    self.isAutocapitalization = isAutocapitalization
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      HStack {
        if isPasswordHidden && isSecure {
          SecureField(placeholder, text: text)
            .textFieldStyle(
              ValidationTextFieldStyle(
                isError: hasError.wrappedValue.0,
                isAutocapitalization: false
              )
            )
        } else {
          TextField(placeholder, text: text)
            .textFieldStyle(
              ValidationTextFieldStyle(
                isError: hasError.wrappedValue.0,
                isAutocapitalization: isAutocapitalization && !isSecure
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
        hasError.wrappedValue.0 ? Color.errorBackgroundColor : Color.backgroundColor
      )
      .cornerRadius(13)
      .overlay {
        if hasError.wrappedValue.0 {
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

      // MARK: Error message
      if hasError.wrappedValue.0, let errorMessage = hasError.wrappedValue.message {
        ErrorMessageText(errorMessage)
      }
    }
    .animation(.easeInOut, value: hasError.wrappedValue.0)

  }
  
}
