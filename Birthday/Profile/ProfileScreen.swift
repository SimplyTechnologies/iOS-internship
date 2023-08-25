
import SwiftUI

struct ProfileScreen: View {
  
  @State private var isEditingModeOff = true
  @State private var firstName = "Shirley"
  @State private var lastName = "Peter"
  
  private var email = "ShirleyPeter01@gmail.com"
  
  private var fullName: String {
    firstName + " " + lastName
  }
  
  // TODO: will be changed
  private var areTextFieldsEdited: Bool {
    firstName != "Shirley" || lastName != "Peter"
  }
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      VStack {
        HStack {
          Spacer()
          Image("LogoBirthApp")
        }
        .padding(
          EdgeInsets(
            top: 0,
            leading: 0,
            bottom: 50,
            trailing: 24
          )
        )
        ProfileView(
          isEditingModeOff: $isEditingModeOff,
          firstName: $firstName,
          lastName: $lastName,
          fullName: fullName,
          email: email
        )
        Spacer()
        if isEditingModeOff {
          Button(
            "Edit Account"
          ) {
            isEditingModeOff.toggle()
          }
          .buttonStyle(PrimaryButtonStyle())
          Button("Sign Out") {
            // TODO: Logic for Sign out and back to Main Page
          }
          .buttonStyle(PrimaryButtonStyle())
        } else {
          Button("Save") {
            isEditingModeOff.toggle()
          }
          .buttonStyle(PrimaryButtonStyle())
          .disabled(!areTextFieldsEdited)
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
