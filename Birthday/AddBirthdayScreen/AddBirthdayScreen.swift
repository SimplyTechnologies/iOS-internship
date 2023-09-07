
import SwiftUI

struct AddBirthdayScreen: View {
  
//  @ObservedObject var viewModel = AddBirthdayViewModel()
  @ObservedObject var viewModel: AddBirthdayViewModel
  @StateObject var homeScreenViewModel: HomeViewModel
  
  var body: some View {
    ZStack {
      Color.backgroundColor
      .ignoresSafeArea()
      ScrollView {
        VStack {
          Image(systemName: "person.circle.fill")
            .resizable()
            .frame(
              width: 150,
              height: 150
            )
            .padding()
            .onTapGesture {
              viewModel.isImagePickerPresented.toggle()
            }
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
            text: $viewModel.birthdayDetails.name
          )
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 14)
              .stroke(
                Color.gray,
                lineWidth: 0.1
              )
          )
          .padding(.horizontal, 60)
          HStack {
            Text("Relation")
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
            text: $viewModel.birthdayDetails.relation
          )
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 14)
              .stroke(
                Color.gray,
                lineWidth: 0.1
              )
          )
          .padding(.horizontal, 60)
          
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
          TextEditor(text: $viewModel.birthdayDetails.message)
            .colorMultiply(.white)
            .cornerRadius(10)
            .frame(
              width: 270,
              height: 200
            )
          DatePicker(
            selection: $viewModel.birthdayDetails.date,
            in: ...Date.now,
            displayedComponents: .date,
            label: {
              Text("Date of Birth:")
                .font(.title3)
            }
          )
          .padding()
          .padding(
            .horizontal, 49
          )
          Button("Save") {
            viewModel.addBirthday(
              by: Api.CreateBirthdayInput(
                name: viewModel.birthdayDetails.name,
                relation: viewModel.birthdayDetails.relation,
                date: viewModel.birthdayDetails.date.stringFromDate()
              )
            )
            homeScreenViewModel.getBirthdays()
          }
          .buttonStyle(PrimaryButtonStyle())
          .padding()
        }
      }
    }
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
    .toolbar {
      Image(
        "LogoBirthApp"
      )
    }
    // TODO: imagePicker
//    .sheet(isPresented: $viewModel.isImagePickerPresented) {
//      ImagePicker(selectedImage: $viewModel.birthdayDetails.image)
//    }
  }
  
}

//struct AddBirthdayScreen_Previews: PreviewProvider {
//
//  static var previews: some View {
////    AddBirthdayScreen(viewModel: AddBirthdayViewModel(birthdayDetails: BirthdayModel(id: 0, userId: 0, name: "", image: "", relation: "", message: "", date: Date(), upcomingBirthday: Date(), upcomingAge: 0, createdAt: Date(), updatedAt: Date()), birthdaysRepository: BirthdaysRepositoryImpl()))
//  }
//
//}
