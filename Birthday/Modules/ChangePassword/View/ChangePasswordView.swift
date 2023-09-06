
import SwiftUI

struct ChangePasswordView: View {
  
  @ObservedObject var viewModel: ChangePasswordViewModel
  
  @State var oldPassword: String = ""
  @State var newPassword: String = ""
  @State var repeatPassword: String = ""
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.all)
      VStack {
        Spacer()
        createCustomTextField(title: "Old Password", text: $oldPassword)
        createCustomTextField(title: "New Password", text: $newPassword)
        createCustomTextField(title: "Repeat New Password", text: $repeatPassword)
        Spacer()
        Button {
          viewModel.changePassword(
            oldPassword: oldPassword,
            newPassword: newPassword
          )
        } label: {
          Text("Done")
            .padding(.horizontal, 28)
            .padding(.vertical, 8)
            .foregroundColor(.white)
            .background(Color.primaryColor)
            .cornerRadius(16)
        }
        Spacer()
      } .padding(.horizontal, 60)
        .font(
          Font.custom(
            weight: .bold,
            size: 18)
        )
    } .navigationBar()
  }
  
  private func createCustomTextField(
    title: String,
    text: Binding<String>
  ) -> some View {
    VStack(alignment: .leading, spacing: 2) {
      Text(title)
        .foregroundColor(.primaryColor)
      SecureField("", text: text)
        .padding(.leading, 5)
        .padding(7)
        .background(Color.white)
        .cornerRadius(50)
    }
  }
}

struct ChangePasswordView_Previews: PreviewProvider {
  static var previews: some View {
    ChangePasswordView(
      viewModel: ChangePasswordViewModel(
        userRepository: UserRepositoryImpl()
      )
    )
  }
}
