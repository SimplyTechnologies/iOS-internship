
import SwiftUI

struct SignInView: View {
  
  @StateObject private var viewModel = SignInViewModel()
  @FocusState private var focusField: TextFieldPlaceholders?
  @State private var checked: Bool = false
  @State private var isPasswordHidden: Bool = true
  
  var emailTetForPreset: String? = nil
  
  var body: some View {
    let textFields: [
      Binding<TextFieldModel>
    ] = [
      $viewModel.email,
      $viewModel.password
    ]
    
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      
      VStack {
        Spacer()
        
        VStack(spacing: 20) {
          
          // MARK: - Title
          TitleText(title: Titles.signIn, size: 20)
            .padding(.top, 20)
          
          // MARK: - TextFields
          VStack(spacing: 0) {
            ForEach(Array(TextFieldPlaceholders.signInCases.enumerated()), id: \.element) { index, placeholder in
              ValidationTextField(
                placeholder: placeholder.description,
                text: textFields[index].text,
                errorMessage: textFields[index].wrappedValue.errorMessage,
                isAutocapitalization: placeholder == .email ? false : true,
                isSecure: placeholder == .password,
                isPasswordHidden: $isPasswordHidden,
                submitLabel: placeholder == .password ? .done : .next
              )
              .keyboardType(placeholder == .email ? .emailAddress : .default)
              .textContentType(placeholder == .email ? .emailAddress : .oneTimeCode)
              .onChange(of: textFields[index].wrappedValue.text) { _ in
                if placeholder == .email {
                  viewModel.trimCharacterOverflow()
                }
                
                viewModel.checkTextFieldAndSetButton(by: placeholder)
              }
              .focused($focusField, equals: placeholder)
              .onSubmit {
                if placeholder == .password {
                  focusField = nil
                } else {
                  focusField = TextFieldPlaceholders(rawValue: index + 3)
                }
              }
            }
            
            HStack(alignment: .center) {
              // MARK: Remember Me Button
              Button {
                viewModel.isCheckboxChecked.toggle()
              } label: {
                ZStack(alignment: .center) {
                  Color.secondaryColor
                  viewModel.isCheckboxChecked ? Image(Images.checkMark.rawValue) : nil
                }
              }
              .frame(width: 18, height: 18)
              .cornerRadius(2)
              
              TitleText(title: Titles.rememberPassword, size: 12)
                .frame(alignment: .center)
              
              Spacer()
              
              // MARK: Forgot Password button
              NavigationLink(ButtonTitles.forgotPassword) {
                EmptyView()
                ForgotPasswordView()
              }
              .font(Font.custom(weight: .bold, size: 12))
              .foregroundColor(Color.primaryColor)
            }
          }
          .padding(.horizontal, 23)
          
          // MARK: - Sign In button
          Button {
            viewModel.signIn()
            viewModel.isLoading = true
          } label: {
            Text(ButtonTitles.signIn)
          }
          .buttonStyle(
            FullRoundedButtonStyle(isDisable: viewModel.isButtonDisabled)
          )
          .padding(.horizontal, 62)
          .disabled(viewModel.isButtonDisabled)
          .padding(.bottom, 20)
        }
        .background(Color.white)
        .cornerRadius(24)
        .padding(.horizontal, 38)
        .offset(x: 0, y: 0)
        
        Spacer()
      }
      
      if viewModel.isLoading {
        LoadingIndicator()
      }
      
    }
    .navigationBar()
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
    .customAlert(
      title: AlertTitles.authorizationError,
      message: NetworkError.authorizationFailure.description,
      isPresented: $viewModel.hasError
    )
  }
  
}

struct SignInView_Previews: PreviewProvider {
  
  static var previews: some View {
    SignInView()
  }
  
}
