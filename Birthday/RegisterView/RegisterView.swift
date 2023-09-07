
import SwiftUI

struct RegisterView: View {
  
  @StateObject private var viewModel = RegisterViewModel()
  @FocusState private var focusField: TextFieldPlaceholders?
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
              ForEach(TextFieldPlaceholders.allCases, id: \.id) { placeholder in
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
                  : (placeholder == .password || placeholder == .repeatedPassword)
                  ? .oneTimeCode
                  : .name
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
                    focusField = TextFieldPlaceholders(rawValue: index + 1)
                  }
                }
              }
            }
            .padding(.horizontal, 37)
            
            // MARK: Register button
            NavigationLink(
              isActive: $viewModel.isLoading
            ) {
              MainView()
            } label: {
              Text(Titles.register)
                .onTapGesture {
                  viewModel.registration() //viewModel.fakeRegistration(result: .failure(NetworkError.registrationError))
                  viewModel.isLoading = true
                }
            }
            .padding(.horizontal, 76)
            .buttonStyle(FullRoundedButtonStyle(isDisable: viewModel.isButtonDisabled))
            .disabled(viewModel.isButtonDisabled)
            
            Spacer(minLength: 30)
          }
          .frame(maxHeight: .infinity)
          .background(.white)
          .cornerRadius(30)
          .padding(.horizontal, 24)
        }
        
        if viewModel.isLoading {
          LoadingIndicator()
        }
        
        if !viewModel.registrationError.1.isEmpty {
          Text(viewModel.registrationError.1)
            .font(Font.custom(weight: .bold, size: 16))
            .foregroundColor(Color.primaryColor)
            .multilineTextAlignment(.center)
            .padding(.all, 15)
            .background(Color.backgroundColor)
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.6), radius: 15)
            .padding(.horizontal)
            .transition(
              .asymmetric(
                insertion: .move(edge: .bottom),
                removal: .opacity
              )
            )
        }
      }

      Spacer()
    }
//    .toast(
//      message: viewModel.registrationError.1,
//      isPresented: $viewModel.registrationError.0
//    )
    .customAlert(
      title: AlertTitles.registrationError,
      message: NetworkError.registrationError.description,
      isPresented: $viewModel.alertIsPresented
    )
    .animation(Animation.easeInOut, value: viewModel.alertIsPresented)
    .navigationBarHidden(true)
    .accentColor(Color.primaryColor)
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
    .navigationBar()
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
  }
}

struct RegisterView_Previews: PreviewProvider {

  static var previews: some View {
    Group {
//      RegisterView()
//        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))

      RegisterView()
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
  }

}
