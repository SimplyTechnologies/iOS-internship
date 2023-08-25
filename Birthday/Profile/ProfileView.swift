
import SwiftUI

struct ProfileView: View {
  
  @Binding var isEditingModeOff: Bool
  @Binding var firstName: String
  @Binding var lastName: String
  
  var fullName: String
  var email: String
  
  var body: some View {
    VStack {
      // TODO:  Birth icon will be there
      if isEditingModeOff {
        Image("profilePicture")
          .resizable()
          .frame(
            width: 150,
            height: 150
          )
          .padding()
        
        Text(fullName)
          .font(.title3)
          .padding()
        
        Text(email)
          .font(.headline)
          .padding()
      } else {
        // TODO: Need to be changed
        Image("Profile")
          .resizable()
          .frame(
            width: 150,
            height: 150
          )
          .padding()
        Text("First Name")
          .frame(
            maxWidth: 250,
            alignment: .leading
          )
          .padding(
            .horizontal, 65
          )
        TextField(
          "First Name",
          text: $firstName
        )
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 14)
            .stroke(
              Color.textFieldBorderColor,
              lineWidth: 0.1
            )
        )
        .padding(
          EdgeInsets(
            top: 0,
            leading: 60,
            bottom: 7,
            trailing: 60
          )
        )
        Text("Last Name")
          .frame(
            maxWidth: 250,
            alignment: .leading
          )
          .padding(
            .horizontal, 65
          )
        
        TextField(
          "Last Name",
          text: $lastName
        )
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 14)
            .stroke(
              Color.textFieldBorderColor,
              lineWidth: 0.1
            )
        )
        .padding(
          EdgeInsets(
            top: 0,
            leading: 60,
            bottom: 0,
            trailing: 60
          )
        )
      }
    }
  }
  
}
