
import SwiftUI

struct NewPasswordView: View {
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @ObservedObject private var viewModel: NewPasswordViewModel
  @State private var isPasswordHidden = true
  
  init(viewModel: NewPasswordViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
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
          
          Button(action: {
            viewModel.resetPassword()
          }) {
            Text("Done")
              .font(
                Font.custom(weight: .bold, size: 18)
              )
              .foregroundColor(.white)
              .frame(width: 100, height: 41)
              .background(Color.primaryColor)
              .cornerRadius(10)
              .padding(.horizontal, 100)
              .padding(.bottom, 20)
          }
          Spacer()
          NavigationLink(
            destination: SignInView(),
            isActive: $viewModel.isPasswordUpdated,
            label: {}
          )
          .opacity(0)
          
        }
        .padding(.horizontal, 37)
        
        VStack {
          Spacer()
          ForEach(viewModel.toasts, id: \.self) {
            ToastView(toast: $0)
              .transition(
                .asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
          }
        }
      }
      .animation(.easeInOut, value: viewModel.toasts.count)
      .zIndex(1)
      
    }
    .onChange(of: viewModel.codeError.message) { _ in
      // swiftlint:disable:next line_length
      if viewModel.codeError.message == "Reset Password Hash expired. Please try to reset again." {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          mode.wrappedValue.dismiss()
        }
      }
    }
  }
  
}
