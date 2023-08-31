
import SwiftUI

struct ProfileView: View {
  
  @ObservedObject var viewModel: ProfileScreenViewModel
  
  var body: some View {
    VStack {
      if viewModel.isEditingModeOff {
        if let image = viewModel.selectedImage {
          Image(uiImage: image)
            .resizable()
            .frame(
              width: 150,
              height: 150
            )
            .cornerRadius(75)
            .padding()
        } else {
          Image("profilePicture")
            .resizable()
            .frame(
              width: 150,
              height: 150
            )
            .padding()
        }
        Text("\(viewModel.user.firstName) \(viewModel.user.lastName)")
          .font(.title3)
          .padding()
          .foregroundColor(.black)
          .multilineTextAlignment(.center)
          .minimumScaleFactor(0.3)
          .lineLimit(1)
        
        Text("\(viewModel.user.email)")
          .font(.headline)
          .padding()
          .foregroundColor(.black)
          .multilineTextAlignment(.center)
          .minimumScaleFactor(0.3)
          .lineLimit(1)

      } else {
        ZStack {
          if let image = viewModel.selectedImage {
            Image(uiImage: image)
              .resizable()
              .frame(
                width: 150,
                height: 150
              )
              .cornerRadius(75)
              .padding()
          } else {
            Image("AddImage")
              .resizable()
              .padding()
              .frame(
                width: 150,
                height: 150
              )
              .cornerRadius(75)
            
          }
        }
        .onTapGesture {
          viewModel.isImagePickerPresented.toggle()
        }
        Text("First Name")
          .frame(
            maxWidth: 250,
            alignment: .leading
          )
          .font(.headline)
          .foregroundColor(.black)
        TextField(
          "First Name",
          text: $viewModel.user.firstName
        )
        .padding(10)
        .foregroundColor(.black)
        .overlay(
          RoundedRectangle(cornerRadius: 14)
            .stroke(
              Color.textFieldBorderColor,
              lineWidth: 0.1
            )
        )
        .padding(.bottom, 7)
        Text("Last Name")
          .frame(
            maxWidth: 250,
            alignment: .leading
          )
          .font(.headline)
          .foregroundColor(.black)
        TextField(
          "Last Name",
          text: $viewModel.user.lastName
        )
        .padding(10)
        .foregroundColor(.black)
        .overlay(
          RoundedRectangle(cornerRadius: 14)
            .stroke(
              Color.textFieldBorderColor,
              lineWidth: 0.1
            )
        )
      }
    }
    .onAppear {
      viewModel.getProfile()
    }
    .sheet(isPresented: $viewModel.isImagePickerPresented) {
      ImagePicker(selectedImage: $viewModel.selectedImage)
    }
    .padding(.horizontal, 60)
  }
  
}
