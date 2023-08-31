
import SwiftUI

struct AddBirthdayScreen: View {
  
  @ObservedObject var viewModel = AddBirthdayViewModel()
  
  var body: some View {
    
    ZStack {
      Color.backgroundColor
      .ignoresSafeArea()
      ScrollView {
        VStack {
          HStack {
            Spacer()
            Image("LogoBirthApp")
          }
          .padding(.horizontal)
          Image(systemName: "person.circle.fill")
            .resizable()
            .frame(
              width: 150,
              height: 150
            )
            .padding()
          HStack {
            Text("Name")
              .font(.title3)
              .frame(
                maxWidth: 250,
                alignment: .leading
              )
              .padding(
                .horizontal, 65
              )
            Spacer()
          }
          TextField(
            "",
            text: $viewModel.name
          )
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 14)
              .stroke(
                Color.gray,
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
          HStack {
            Text("Bio")
              .font(.title3)
              .frame(
                maxWidth: 250,
                alignment: .leading
              )
              .padding(
                .horizontal, 65
              )
            Spacer()
          }
          TextEditor(text: $viewModel.addBirthdayViewModel.message)
            .colorMultiply(.white)
            .cornerRadius(10)
            .frame(
              width: 270,
              height: 200)
          DatePicker(selection: $viewModel.addBirthdayViewModel.date, in: ...Date.now, displayedComponents: .date) {
            Text("Date of Birth:")
              .font(.title3)
          }
          .padding()
          .padding(.horizontal, 49)
          HStack {
            Text("Phone number")
              .font(.title3)
              .frame(
                maxWidth: 250,
                alignment: .leading
              )
              .padding(
                .horizontal, 65
              )
            Spacer()
          }
          TextField(
            "",
            text: $viewModel.phoneNumberInfo.phoneNumber
          )
          .onChange(of: viewModel.phoneNumberInfo.phoneNumber) { newValue in
            viewModel.phoneNumberInfo.isValid = viewModel.validatePhoneNumber(newValue)
          }
          .keyboardType(.phonePad)
          .foregroundColor(viewModel.phoneNumberInfo.isValid ? .green : .red)
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 14)
              .stroke(
                Color.gray,
                lineWidth: 0.1
              )
          )
          .padding(.horizontal, 60)
          Button("Save") {
              // TODO: Go to home
          }
          .buttonStyle(PrimaryButtonStyle())
          .padding()
        }
      }
    }
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
  }
  
}

struct AddBirthdayScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    AddBirthdayScreen()
  }
  
}
