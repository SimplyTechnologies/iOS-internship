
import SwiftUI

struct ForgotPasswordView: View {
  
  @StateObject private var viewModel = ForgotPasswordViewModel(
    signInRepository: SignInRepositoryImpl()
  )
  @State private var isVerificationCodeViewVisible = false
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      
      VStack(alignment: .center, spacing: 30) {
        SimpleTextField(
          title: "Email",
          placeholder: "Enter your email",
          text: $viewModel.email.text,
          errorMessage: viewModel.hasError.message ?? "",
          isAutocapitalization: false,
          isSecure: false,
          isPasswordHidden: $viewModel.isPasswordHidden,
          submitLabel: .next
        )
        .accentColor(.primaryColor)
        .shadow(
          color: Color.gray.opacity(0.3),
          radius: 0.5,
          x: 0.5,
          y: 0.5
        )
        .keyboardType(.emailAddress)
        .onChange(of: viewModel.email.text) { _ in
          viewModel.checkAndSetButton()
        }
        
        Button(action: {
          viewModel.getVerificationCode()
          viewModel.showToast(
            message:
              // swiftlint:disable:next line_length
              "We have sent an email with a verification code, if there is an account with a provided email address"
          )
        }
        ) {
          Text("Get The Code")
            .font(
              Font.custom(weight: .bold, size: 18)
            )
            .foregroundColor(.primaryColor)
        }
        .frame(width: 190, height: 41)
        .background(.white)
        .cornerRadius(12)
        .shadow(
          color: Color.gray.opacity(0.3),
          radius: 0.5, x: 0.5, y: 0.5
        )
        .lineLimit(1)
        .disabled(viewModel.isDisable)
        .padding(.horizontal, 40)
        
        Spacer()
        
        if viewModel.isCodeGot {
          VStack(alignment: .center) {
            VStack(alignment: .center, spacing: 23) {
              Text("Password Code")
                .font(
                  Font.custom(weight: .bold, size: 20)
                )
                .foregroundColor(Color.primaryColor)
                .padding(.top, 27)
              
              TextField("1 2 3 4 5 6", text: $viewModel.codeText)
                .font(
                  Font.custom(weight: .bold, size: 18)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.primaryColor)
                .padding(.horizontal, 38)
                .background(Color.backgroundColor)
                .cornerRadius(2)
                .padding(.bottom, 28)
                .padding(.horizontal, 40)
                .keyboardType(.numberPad)
                .submitLabel(.done)
                .onChange(of: viewModel.codeText) { newValue in
                  if newValue.count > 6 {
                    viewModel.codeText = String(newValue.prefix(6))
                  }
                }
                .toolbar {
                  ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                      UIApplication.shared.endEditing()
                    }
                  }
                }
            }
            .background(.white)
            .cornerRadius(13)
            .padding(.bottom, 100)
          }
          
          NavigationLink(
            destination: NewPasswordView(
              viewModel: NewPasswordViewModel(
                signInRepository: SignInRepositoryImpl(),
                hash: viewModel.codeText,
                email: viewModel.email.text
              )
            ),
            isActive: $viewModel.navigateToResetPassword
          ) {
            Text("Set New Password")
          }
          .buttonStyle(
            FullRoundedButtonStyle(isDisable: true)
          )
          .padding(.bottom, 75)
          .padding(.horizontal, 20)
        } else {
          Spacer()
        }
      }
      .padding(.top, 100)
      .padding(.horizontal, 60)
      
      VStack {
        Spacer()
        ForEach(viewModel.toasts, id: \.self) {
          ToastView(toast: $0)
            .transition(
              .asymmetric(
                insertion: .move(edge: .bottom),
                removal: .opacity)
            )
        }
      }
      .animation(
        .easeInOut,
        value: viewModel.toasts.count
      )
      .zIndex(1)
    }
  }
  
}
