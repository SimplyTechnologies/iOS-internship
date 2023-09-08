
import SwiftUI

struct ProfileScreen: View {
  
  @ObservedObject var viewModel = ProfileScreenViewModel(
    userRepository: UserRepositoryImpl()
  )
  
  @Environment(\.presentationMode) var presentationMode
  
  @State var wantToLogout: Bool = false
  
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
                wantToLogout = true
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
      .customAlert(
        type: .secondary,
        title: "",
        message: "Are you sure you want to sign out?",
        secondaryAction: {
          viewModel.signOut()
            presentationMode.wrappedValue.dismiss()
          }, isPresented: $wantToLogout)
      .animation(.easeInOut, value: wantToLogout)
  }
  
}

struct ProfileScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    ProfileScreen()
  }
  
}
