
import SwiftUI

struct RegisterView: View {
  
  @StateObject private var viewModel = RegisterViewModel()
  @FocusState private var focusField: TextFieldPlaceholder?
  @State private var isPasswordHidden: Bool = true
      
  var body: some View {
    let textFields: [
      Binding<TextFieldModel>
    ] = [
      $viewModel.name,
      $viewModel.surname,
      $viewModel.email,
      $viewModel.password,
      $viewModel.repeatedPassword
    ]
    
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      
      VStack {
        Spacer(minLength: 30)
        
        ScrollView(showsIndicators: false) {
          VStack(spacing: 30) {
            Spacer(minLength: 15)
            
            TitleText(
              title: Titles.register,
              size: 30
            )
            
            // MARK: - TextFields
            VStack(spacing: 0) {
              ForEach(TextFieldPlaceholder.allCases, id: \.id) { placeholder in
                let index = placeholder.id
                
                ValidationTextField(
                  placeholder: placeholder.description,
                  text: textFields[index].text,
                  errorMessage: textFields[index].wrappedValue.errorMessage,
                  isAutocapitalization: placeholder == .email ? false : true,
                  isSecure: placeholder == .password || placeholder == .repeatedPassword,
                  isPasswordHidden: $isPasswordHidden,
                  submitLabel: placeholder == .repeatedPassword ? .done : .next
                )
                .textContentType(
                  placeholder == .name
                  ? .givenName
                  : placeholder == .surname
                    ? .familyName
                    : placeholder == .email
                      ? .emailAddress
                      : .none
                )
                .keyboardType(
                  placeholder == .email
                  ? .emailAddress
                  : .default
                )
                .onChange(of: textFields[index].wrappedValue.text) { _ in
                  viewModel.checkTextField(by: placeholder)
                  
                  if placeholder == .password {
                    viewModel.resetRepeatedPasswordIfNeeded()
                  }
                }
                .focused($focusField, equals: placeholder)
                .onSubmit {
                  if placeholder == .repeatedPassword {
                    focusField = nil
                  } else {
                    focusField = TextFieldPlaceholder(rawValue: index + 1)
                  }
                }
              }
            }
            .padding(.horizontal, 37)
            
            // MARK: Register button
            NavigationLink(
              isActive: $viewModel.hasUserRegistered
            ) {
              MainView()
            } label: {
              Text(Titles.register)
                .onTapGesture {
                  viewModel.registration()
                  viewModel.isLoading = true
                }
            }
            .padding(.horizontal, 76)
            .buttonStyle(
              FullRoundedButtonStyle(
                isDisable: viewModel.isButtonDisabled
              )
            )
            .disabled(viewModel.isButtonDisabled)
            
            Spacer(minLength: 30)
          }
          .frame(maxHeight: .infinity)
          .background(.white)
          .cornerRadius(30)
          .padding(.horizontal, 24)
        }
        
        if !viewModel.registrationErrorMessage.isEmpty {
          ToastText(viewModel.registrationErrorMessage)
        }
        
        if !viewModel.registrationSuccessMessage.isEmpty {
          ToastText(viewModel.registrationSuccessMessage)
        }
      }

      Spacer()
    }
    .customAlert(
      type: .primary, title: AlertTitles.registrationError,
      message: NetworkError.registrationError.description,
      isPresented: $viewModel.alertIsPresented
    )
    .overlay {
      if viewModel.isLoading {
        LoadingIndicator()
      }
    }
    .animation(Animation.easeInOut, value: viewModel.alertIsPresented)
    .navigationBarHidden(true)
    .accentColor(Color.primaryColor)
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
    .navigationBar()
  }
  
}

struct RegisterView_Previews: PreviewProvider {
  
  static var previews: some View {
    RegisterView()
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
  }

}
