import SwiftUI

struct ForgotPasswordView: View {
  
  // MARK: - Properties
  @StateObject private var viewModel = ForgotPasswordViewModel()
  private let title: String = "Email"
  private let placeholder: String = "Enter your email"
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        // MARK: Title
        HStack {
          Text(title)
            .font(Font.custom(weight: .bold, size: 18))
            .foregroundColor(
              Color.primaryColor.opacity(0.7)
            )
            .padding(.leading, 61 + 5) // xOffset = 5
    
          Spacer()
        }
          
        // MARK: TextField
        TextField(placeholder, text: $viewModel.text)
          .foregroundColor(
            Color.primaryColor.opacity(0.74)
          )
          .font(
            Font.custom(weight: .bold, size: 14)
          )
          .padding(.leading, 20)
          .frame(height: 41)
          .background(.white)
          .cornerRadius(66)
          .padding(.horizontal, 61)
        
        Button {
          print("Button pressed")
        } label: {
          Text(Titles.getTheCode)
            .font(
              Font.custom(weight: .bold, size: 18)
            )
            .foregroundColor(Color(red: 0.59, green: 0.24, blue: 0.35))
            .padding(.horizontal, 38)
          
        }
        .frame(height: 41)
        .background(.white)
        .cornerRadius(12)
        .padding(.top, 37)
        .disabled(viewModel.isCodeGot)
        
        if viewModel.isCodeGot {
          VStack(alignment: .center, spacing: 23) {
            Text(Titles.passwordCode)
              .font(
                Font.custom(weight: .bold, size: 18)
              )
              .foregroundColor(Color(red: 0.59, green: 0.24, blue: 0.35))
              .padding(.top, 27)
            
            TextField("1 2 3 4", text: $viewModel.passwordCode)
              .font(
                Font.custom(weight: .bold, size: 18)
              )
              .foregroundColor(.black)
              .padding(.horizontal, 38)
              .background(Color(red: 1, green: 0.96, blue: 0.96))
              .cornerRadius(2)
              .padding(.bottom, 28)
              .padding(.horizontal, 72)
          }
          .background(.white)
          .cornerRadius(13)
          .padding(.top, 78)
          .padding(.horizontal, 60)
        }
      }
    }
  }
  
}

// MARK: - Preview
struct ForgotPasswordView_Previews: PreviewProvider {
  
  static var previews: some View {
    ForgotPasswordView()
  }
  
}
