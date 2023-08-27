
import SwiftUI

struct ProfileScreen: View {
  
  @ObservedObject var viewModel = ProfileScreenViewModel()
  
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
        ProfileView()
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
          Button("Sign Out") {
            // TODO: Logic for Sign out and back to Main Page
          }
          .buttonStyle(PrimaryButtonStyle())
        } else {
          Button("Save") {
            viewModel.isEditingModeOff.toggle()
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
    ProfileScreen()
  }
  
}
