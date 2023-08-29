
import SwiftUI

struct SignInView: View {
  
  // MARK: - Properties
  @StateObject private var viewModel = SignInViewModel()
  @FocusState private var focusField: TextFieldPlaceholders?
  @State private var checked: Bool = false
    
  // MARK: - Body
  var body: some View {
    NavigationView {
      ZStack {
        Color.backgroundColor
          .ignoresSafeArea()

        Spacer()
        
        VStack {
          // MARK: Title
          TitleText(title: Titles.signIn, size: 20)
            .padding(.top, 15)
            .padding(.bottom, 25)
          
          // MARK: - TextFields
          VStack(spacing: 0) {
            
            // MARK: Email
            ValidationTextField(
              placeholder: TextFieldPlaceholders.email.rawValue,
              text: $viewModel.email.text,
              hasError: $viewModel.email.error,
              isAutocapitalization: false
            )
            .keyboardType(.emailAddress)
            .padding(.bottom, viewModel.email.error.0 ? 5 : 30)
            .onAppear {
              viewModel.getDataFromStore()
            }
            .onChange(of: viewModel.email.text) { text in
              let charLimit = 60

              if text.count > charLimit {
                viewModel.email.text = String(text.prefix(charLimit))
              }
              
              viewModel.checkAndSetButton(by: .email)
            }
            .focused($focusField, equals: .email)
            .submitLabel(.next)
            .onSubmit {
              focusField = .password
            }
            
            // MARK: Password
            ValidationTextField(
              placeholder: TextFieldPlaceholders.password.rawValue,
              text: $viewModel.password.text,
              hasError: $viewModel.password.error,
              isSecure: true
            )
            .padding(.bottom, viewModel.password.error.0 ? 5 : 30)
            .onAppear {
              viewModel.getDataFromStore()
            }
            .onChange(of: viewModel.password.text) { _ in
              viewModel.checkAndSetButton(by: .password)
            }
            .focused($focusField, equals: .password)
            .submitLabel(.done)
            .onSubmit {
              focusField = nil
            }
            
            HStack(alignment: .center) {
              // MARK: Remember Me Button
              Button {
                viewModel.isChecked.toggle()
              } label: {
                ZStack(alignment: .center) {
                  Color.secondaryColor
                  viewModel.isChecked ? Image(Images.checkMark.rawValue) : nil
                }
              }
              .frame(width: 18, height: 18)
              .cornerRadius(2.31)
              
              TitleText(title: Titles.rememberPassword, size: 12)
                .frame(alignment: .center)
              
              Spacer()
              
              // MARK: Forgot Password button
              NavigationLink(ButtonTitles.forgotPassword) {
                ForgotPasswordView()
              }
              .font(Font.custom(weight: .bold, size: 12))
              .foregroundColor(Color.primaryColor)
            }
          }
          .padding(.horizontal, 23)
          .padding(.bottom, 18)
          
          // MARK: Sign In button
          NavigationLink(
            destination: TabBarView(),
            isActive: $viewModel.isValidationSuccess
          ) {
            Text(ButtonTitles.signIn)
              .onTapGesture {
                viewModel.setIfIsChecked()
                viewModel.signIn()
              }
          }
          .buttonStyle(
            FullRoundedButtonStyle(isDisable: viewModel.isDisable)
          )
          .padding(.horizontal, 62)
          .padding(.bottom, 26)
          .disabled(viewModel.isDisable)
          .alert(AlertTitles.authorizationError, isPresented: $viewModel.hasError) {
            Button(ButtonTitles.ok, role: .cancel) {}
          } message: {
            Text(NetworkError.validationFailure.description)
          }
        }
        .background(Color.white)
        .cornerRadius(24)
        .padding(.horizontal, 38)
        .offset(x: 0, y: 0)
    
        Spacer()
      }
    }
  }
}

// MARK: - Preview
struct SignInView_Previews: PreviewProvider {
  
  static var previews: some View {
    SignInView()
  }
  
}
