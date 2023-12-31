
import SwiftUI

struct NewPasswordView: View {
  
  @Environment(\.dismiss) var dismiss
  @ObservedObject private var viewModel: NewPasswordViewModel
  @State private var isPasswordHidden = true
  
  init(viewModel: NewPasswordViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 0) {
        SimpleTextField(
          title: "New Password",
          placeholder: "",
          text: $viewModel.password.text,
          errorMessage: viewModel.password.errorMessage,
          isAutocapitalization: false,
          isSecure: true,
          isPasswordHidden: $isPasswordHidden, submitLabel: .next
        )
        .shadow(
          color: Color.gray.opacity(0.3),
          radius: 0.5, x: 0.5, y: 0.5
        )
        .accentColor(.primaryColor)
        .padding(.top, 100)
        
        SimpleTextField(
          title: "Repeat New Password",
          placeholder: "",
          text: $viewModel.repeatedPassword.text,
          errorMessage: viewModel.repeatedPassword.errorMessage,
          isAutocapitalization: false,
          isSecure: true,
          isPasswordHidden: $isPasswordHidden,
          submitLabel: .done
        )
        .shadow(
          color: Color.gray.opacity(0.3),
          radius: 0.5, x: 0.5, y: 0.5
        )
        .accentColor(.primaryColor)
        Spacer()
        
        HStack {
          Spacer()
          Button(action: {
            viewModel.resetPassword()
          }) {
            Text("Done")
              .font(
                Font.custom(weight: .bold, size: 18)
              )
              .foregroundColor(.white)
              .frame(width: 100.0, height: 41.0)
              .background(Color.primaryColor)
              .cornerRadius(10)
          }
          NavigationLink(
            destination: MainView(),
            isActive: $viewModel.isPasswordUpdated,
            label: {}
          )
          .opacity(0)
          Spacer()
        }
        
        Spacer()
      }
      .padding(.horizontal, 37)
    }
    .navigationBar()
    .customAlert(
      type: .primary, title: "",
      message: "The code you entered was not correct. Please double-check the code and try again.",
      action: {
        dismiss()
      }, isPresented: $viewModel.showAlert)
  }
}
  

struct NewPasswordView_Previews: PreviewProvider {
  
  static var previews: some View {
    NewPasswordView(viewModel: NewPasswordViewModel(
      signInRepository: SignInRepositoryImpl(),
      hash: "",
      email: "")
    )
  }
  
}
