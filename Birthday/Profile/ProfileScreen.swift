
import SwiftUI

struct ProfileScreen: View {
    
  @ObservedObject var viewModel = ProfileScreenViewModel(
    userRepository: UserRepositoryImpl()
  )
  
  var body: some View {
    if viewModel.isLoading {
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
            if !viewModel.isEditingModeOff {
              Button {
                viewModel.isEditingModeOff = true
              } label: {
                Image(systemName: "chevron.left")
                  .foregroundColor(.secondaryColor)
              }
            }

            Spacer()
            Logo()
          }
          .padding()
          ProfileView(viewModel: viewModel)
          Spacer()
          if viewModel.isEditingModeOff {
            Button(
              "Edit Account"
            ) {
              viewModel.startToEdit()
              
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
              viewModel.saveProfileInfo()
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
