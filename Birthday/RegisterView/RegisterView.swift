
import SwiftUI

struct RegisterView: View {
  
  // MARK: - Properties
  @StateObject private var viewModel = RegisterViewModel()
  @FocusState private var focusField: TextFieldPlaceholders?
  
  // MARK: - Body
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      
      ScrollView(showsIndicators: false) {
        VStack {
          
          // MARK: - Title
          TitleText(
            title: Titles.register,
            size: 30
          )
          .padding(.top, 15)
          .padding(.bottom, 31)
          
          
          // MARK: - TextFields
          VStack(spacing: 0) {
            
            // MARK: Name
            ValidationTextField(
              placeholder: TextFieldPlaceholders.name.rawValue,
              text: $viewModel.name.text,
              hasError: $viewModel.name.error
            )
            .padding(.bottom, viewModel.name.error.0 ? 5 : 30)
            .textContentType(.givenName)
            .onChange(of: viewModel.name.text) { _ in
              viewModel.checkTextField(by: .name)
            }
            .focused($focusField, equals: .name)
            .submitLabel(.next)
            .onSubmit {
              focusField = .surname
            }
            
            // MARK: Surname
            ValidationTextField(
              placeholder: TextFieldPlaceholders.surname.rawValue,
              text: $viewModel.surname.text,
              hasError: $viewModel.surname.error
            )
            .padding(.bottom, viewModel.surname.error.0 ? 5 : 30)
            .textContentType(.familyName)
            .onChange(of: viewModel.surname.text) { _ in
              viewModel.checkTextField(by: .surname)
            }
            .focused($focusField, equals: .surname)
            .submitLabel(.next)
            .onSubmit {
              focusField = .email
            }
            
            // MARK: Email
            ValidationTextField(
              placeholder: TextFieldPlaceholders.email.rawValue,
              text: $viewModel.email.text,
              hasError: $viewModel.email.error,
              isAutocapitalization: false
            )
            .padding(.bottom, viewModel.email.error.0 ? 5 : 30)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .onChange(of: viewModel.email.text) { _ in
              viewModel.checkTextField(by: .email)
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
            .textContentType(.password)
            .onChange(of: viewModel.password.text) { _ in
              viewModel.checkTextField(by: .password)
              
              if viewModel.password.text != viewModel.repeatPassword.text {
                viewModel.repeatPassword.text = ""
              }
            }
            .focused($focusField, equals: .password)
            .submitLabel(.next)
            .onSubmit {
              focusField = .repeatPassword
            }
            
            // MARK: Repeat password
            ValidationTextField(
              placeholder: TextFieldPlaceholders.repeatPassword.rawValue,
              text: $viewModel.repeatPassword.text,
              hasError: $viewModel.repeatPassword.error,
              isSecure: true
            )
            .padding(.bottom, viewModel.repeatPassword.error.0 ? 5 : 30)
            .textContentType(.password)
            .onChange(of: viewModel.repeatPassword.text) { _ in
              viewModel.checkTextField(by: .repeatPassword)
            }
            .focused($focusField, equals: .repeatPassword)
            .submitLabel(.next)
            .onSubmit {
              focusField = nil
            }
          }
          .padding(.horizontal, 37)
          
          // MARK: - Register button
          NavigationLink {
            SignInView()
          } label: {
            Text(Titles.register)
          }
          .padding(.bottom, 30)
          .padding(.horizontal, 76)
          .buttonStyle(FullRoundedButtonStyle(isDisable: viewModel.isDisable))
          .disabled(viewModel.isDisable)
        }
        .frame(maxHeight: .infinity)
        .background(.white)
        .cornerRadius(30)
        .padding(.horizontal, 24)
        
      }
    }
  }
  
}

// MARK: - Preview
struct RegisterView_Previews: PreviewProvider {
  
  static var previews: some View {
      RegisterView()
  }
  
}
