
import SwiftUI

struct ProfileScreen: View {
  
  @State var isLoading: Bool = false
  
  @ObservedObject var viewModel = ProfileScreenViewModel(
    userRepository: UserRepositoryImpl()
  )
  
  var body: some View {
    if isLoading {
      VStack {
        Spacer()
        ProgressView()
        Spacer()
      }
    } else {
      ZStack {
        Color.backgroundColor
          .ignoresSafeArea()
        VStack {
          HStack {
            Spacer()
            Image("LogoBirthApp")
          }
          .padding()
          ProfileView(viewModel: viewModel)
            .environmentObject(viewModel)
          Spacer()
          Spacer()
          if viewModel.isEditingModeOff {
            Button(
              "Edit Account"
            ) {
              viewModel.isEditingModeOff.toggle()
              viewModel.selectedImage = nil
              
            }
            .buttonStyle(PrimaryButtonStyle())
            .minimumScaleFactor(0.5)
            Button("Sign Out") {
              // TODO: Logic for Sign out and back to Main Page
            }
            .minimumScaleFactor(0.5)
            .buttonStyle(PrimaryButtonStyle())
          } else {
            Button("Save") {
              isLoading = true
              viewModel.editProfileInfo(
                payload: Api.UpdateProfileInput(
                  firstName: viewModel.user.firstName ?? "",
                  lastName: viewModel.user.lastName ?? "",
                  image: viewModel.selectedImage?.base64 ?? ""
                )
              )
              DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.isEditingModeOff.toggle()
                viewModel.getProfileInfo()
                isLoading = false
              }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!viewModel.areTextFieldsEdited)
          }
          Spacer()
        }
        .padding(.horizontal)
      }
    }
  }
  
}

struct ProfileScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    ProfileScreen()
  }
  
}
