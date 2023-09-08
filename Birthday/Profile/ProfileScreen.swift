
import SwiftUI

struct ProfileScreen: View {
  
  @ObservedObject var viewModel = ProfileScreenViewModel(
    userRepository: UserRepositoryImpl()
  )
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.top)
      VStack {
        HStack {
          if !viewModel.isEditingModeOff {
            Button {
              viewModel.isEditingModeOff = true
            } label: {
              Image("Back")
            }
          }
          
          Spacer()
          Image(Images.logo.rawValue)
        } .padding(.horizontal, 24)
        ScrollView {
          VStack {
            ProfileView(viewModel: viewModel)
            Spacer()
              .frame(height: 120)
            if viewModel.isEditingModeOff {
              Button(
                "Edit Account"
              ) {
                viewModel.startToEdit()
                
              }
              .buttonStyle(PrimaryButtonStyle())
              .minimumScaleFactor(0.5)
              
              NavigationLink {
                ChangePasswordView(
                  viewModel: ChangePasswordViewModel(
                    userRepository: UserRepositoryImpl()
                  )
                )
              } label: {
                Text("Change Password")
              }
              .minimumScaleFactor(0.5)
              .buttonStyle(PrimaryButtonStyle())
              
              Button {
                viewModel.signOut()
                presentationMode.wrappedValue.dismiss()
              } label: {
                Text("Sign Out")
              }
              .minimumScaleFactor(0.5)
              .buttonStyle(PrimaryButtonStyle())
            } else {
              Button("Save") {
                viewModel.saveProfileInfo()
              }
              .buttonStyle(PrimaryButtonStyle())
              .disabled(!viewModel.areTextFieldsEdited)
            }
          } .padding(.horizontal, 24)
        }
      }
      .font(Font.custom(weight: .bold, size: 20))
    } .navigationBarHidden(true)
    .overlay {
      viewModel.isLoading ? ProgressView() : nil
    }
  }
  
}

struct ProfileScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    ProfileScreen()
  }
  
}
