
import SwiftUI

struct SimpleTextField: View {
  
  @Binding var isPasswordHidden: Bool
  
  private let title: String
  private let placeholder: String
  private let text: Binding<String>
  private let errorMessage: String
  private let isAutocapitalization: Bool
  private let submitLabel: SubmitLabel
  private var isSecure: Bool
  
  init(
    title: String,
    placeholder: String,
    text: Binding<String>,
    errorMessage: String,
    isAutocapitalization: Bool = true,
    isSecure: Bool = false,
    isPasswordHidden: Binding<Bool>,
    submitLabel: SubmitLabel = .next
  ) {
    self.title = title
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
      
      Text(title)
        .font(
          Font.custom(weight: .medium, size: 18)
            .weight(.bold)
        )
        .foregroundColor(Color.primaryColor)
        .offset(x: 5)
      
      HStack {
        if isPasswordHidden && isSecure {
          SecureField(placeholder, text: text)
            .textFieldStyle(
              SimpleTextFieldStyle(
                isAutocapitalization: false
              )
            )
          
        } else {
          TextField(placeholder, text: text)
            .textFieldStyle(
              SimpleTextFieldStyle(
                isAutocapitalization: isAutocapitalization && !isSecure
              )
            )
        }
        
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
        errorMessage.isEmpty ? Color.white : Color.errorBackgroundColor
        
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
