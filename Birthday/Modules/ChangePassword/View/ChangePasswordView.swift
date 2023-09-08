
import SwiftUI

struct ChangePasswordView: View {
  
  @ObservedObject var viewModel: ChangePasswordViewModel
  @FocusState private var focusField: ChangePasswordTextFieldPlaceholder?
  @State var isPasswordHidden: Bool = true
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Spacer()
        
        SimpleTextField(
          title: Titles.oldPassword,
          placeholder: ChangePasswordTextFieldPlaceholder.oldPassword.description,
          text: $viewModel.oldPassword.text,
          errorMessage: viewModel.oldPassword.errorMessage,
          isSecure: true,
          isPasswordHidden: $isPasswordHidden
        )
        .textContentType(.none)
        .onChange(of: viewModel.oldPassword.text) { _ in
          viewModel.checkOldPassword()
        }
        .focused($focusField, equals: .oldPassword)
        .onSubmit {
          focusField = .newPassword
        }
        
        SimpleTextField(
          title: Titles.newPassword,
          placeholder: ChangePasswordTextFieldPlaceholder.newPassword.description,
          text: $viewModel.newPassword.text,
          errorMessage: viewModel.newPassword.errorMessage,
          isSecure: true,
          isPasswordHidden: $isPasswordHidden
        )
        .textContentType(.none)
        .onChange(of: viewModel.newPassword.text) { _ in
          viewModel.checkNewPassword()
          viewModel.resetRepeatedPasswordIfNeeded()
        }
        .focused($focusField, equals: .newPassword)
        .onSubmit {
          focusField = .repeatNewPassword
        }
        
        SimpleTextField(
          title: Titles.repeatNewPassword,
          placeholder: ChangePasswordTextFieldPlaceholder.repeatNewPassword.description,
          text: $viewModel.repeatNewPassword.text,
          errorMessage: viewModel.repeatNewPassword.errorMessage,
          isSecure: true,
          isPasswordHidden: $isPasswordHidden
        )
        .textContentType(.none)
        .onChange(of: viewModel.repeatNewPassword.text) { _ in
          viewModel.checkRepeatedNewPassword()
        }
        .focused($focusField, equals: .repeatNewPassword)
        .onSubmit {
          focusField = nil
        }
        
        Spacer()
        
        Button {
          viewModel.changePassword()
          presentationMode.wrappedValue.dismiss()
        } label: {
          Text("Done")
            .padding(.horizontal, 28)
            .padding(.vertical, 8)
            .foregroundColor(.white)
            .background(Color.primaryColor)
            .cornerRadius(16)
        }
        
        Spacer()
      }
      .padding(.horizontal, 60)
      .font(
        Font.custom(
          weight: .bold,
          size: 18)
      )
    }
    .navigationBar()
  }
  
}

struct ChangePasswordView_Previews: PreviewProvider {
  
  static var previews: some View {
    ChangePasswordView(
      viewModel: ChangePasswordViewModel(
        userRepository: UserRepositoryImpl()
      )
    )
  }
  
}
