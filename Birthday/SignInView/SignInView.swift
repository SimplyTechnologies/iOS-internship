
import SwiftUI

struct SignInView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var viewModel = SignInViewModel()
  @State private var checked: Bool = false
  @FocusState private var focusField: TextFieldPlaceholders?
  @GestureState private var dragOffset = CGSize.zero
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      
      VStack {
        HStack {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(Images.backButton.rawValue)
          }
          
          Spacer()
          Image(Images.logo.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
              width: 88,
              height: 40
            )
        }
        .padding(.horizontal)
        
        Spacer()
        
        VStack {
          
          // MARK: - Title
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
              viewModel.getEmailFromStore()
            }
            .onChange(of: viewModel.email.text) { _ in
              viewModel.trimCharacterOverflow()
              viewModel.checkFieldAndSetButton(by: .email)
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
              viewModel.getEmailFromStore()
            }
            .onChange(of: viewModel.password.text) { _ in
              viewModel.checkFieldAndSetButton(by: .password)
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
              .cornerRadius(2)
              
              TitleText(title: Titles.rememberPassword, size: 12)
                .frame(alignment: .center)
              
              Spacer()
              
              // MARK: Forgot Password button
              NavigationLink(ButtonTitles.forgotPassword) {
                EmptyView()
                //              ForgotPasswordView()
              }
              .font(Font.custom(weight: .bold, size: 12))
              .foregroundColor(Color.primaryColor)
            }
          }
          .padding(.horizontal, 23)
          .padding(.bottom, 18)
          
          // MARK: - Sign In button
          Button(action: {
            viewModel.signIn()
          }, label: {
            Text(ButtonTitles.signIn)
              .onTapGesture {
                viewModel.isLoading = true
                viewModel.signIn()
              }
          })
          .buttonStyle(
            FullRoundedButtonStyle(isDisable: viewModel.isDisable)
          )
          .padding(.horizontal, 62)
          .padding(.bottom, 26)
          .disabled(viewModel.isDisable)
          .alert(
            AlertTitles.authorizationError,
            isPresented: $viewModel.hasError
          ) {
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
      
      if viewModel.isLoading {
        LoadingIndicator()
      }
    }
    .navigationBarHidden(true)
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
    .accentColor(Color.primaryColor)
  }
  
}

struct SignInView_Previews: PreviewProvider {
  
  static var previews: some View {
    SignInView()
  }
  
}
