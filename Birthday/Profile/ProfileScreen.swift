
import SwiftUI

struct ProfileScreen: View {
  
  @ObservedObject var viewModel: ProfileScreenViewModel
  
  var body: some View {
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
            viewModel.isEditingModeOff.toggle()
            viewModel.editFirstName(firstName: viewModel.user.firstName)
            viewModel.editLastName(lastName: viewModel.user.lastName)
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

struct ProfileScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    ProfileScreen(
      viewModel: ProfileScreenViewModel(
        birthdaysRepository: BirthdaysRepositoryImpl()
      )
    )
  }
  
}
