
import SwiftUI

struct ProfileView: View {
  
  @ObservedObject var viewModel: ProfileScreenViewModel
  
  var body: some View {
    VStack {
      if viewModel.isEditingModeOff {
        if !viewModel.user.image.isEmpty {
          Image(uiImage: UIImage(data: Data(base64Encoded: viewModel.user.image)!)!)
            .resizable()
            .frame(
              width: 150,
              height: 150
            )
            .cornerRadius(75)
        } else {
          ZStack {
            Color.secondaryColor
            Image(systemName: "person")
              .resizable()
              .scaledToFit()
              .foregroundColor(Color.white)
              .frame(width: 80)
          }
          .frame(width: 150, height: 150)
          .cornerRadius(75)
        }
        VStack(spacing: 10) {
          Text(viewModel.fullName)
            .font(Font.custom(weight: .bold, size: 20))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
          
          Text(viewModel.user.email)
            .font(Font.custom(weight: .bold, size: 20))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
        }
      } else {
        ZStack(alignment: .topTrailing) {
          
          ZStack {
            if let image = viewModel.selectedImage {
              Image(uiImage: image)
                .resizable()
                .frame(
                  width: 150,
                  height: 150
                )
                .cornerRadius(75)
            } else {
              if !viewModel.user.image.isEmpty {
                Image(uiImage: UIImage(data: Data(base64Encoded: viewModel.user.image)!)!)
                  .resizable()
                  .frame(
                    width: 150,
                    height: 150
                  )
                  .cornerRadius(75)
              } else {
                Image("circle")
              }
            }
            
          }
          ZStack {
            Color.white
              .frame(width: 40, height: 40)
              .cornerRadius(50)
            Image(systemName: "plus.circle.fill")
              .resizable()
              .frame(width: 40, height: 40)
              .foregroundColor(.primaryColor)
          }
        }
        .onTapGesture {
          viewModel.isImagePickerPresented.toggle()
        }
        VStack(alignment: .leading, spacing: 0) {
          Text("First Name")
            .foregroundColor(.primaryColor)
            .padding(.leading, 4)
          TextField(
            "First Name",
            text: $viewModel.user.firstName
          )
          .autocorrectionDisabled()
          .padding(10)
          .foregroundColor(.black)
          .overlay(
            RoundedRectangle(cornerRadius: 14)
              .stroke(
                Color.textFieldBorderColor,
                lineWidth: 0.1
              )
          )
          .background(.white)
          .cornerRadius(14)
        }
        
        VStack(alignment: .leading, spacing: 0) {
          Text("Last Name")
            .foregroundColor(.primaryColor)
            .padding(.leading, 4)
          TextField(
            "Last Name",
            text: $viewModel.user.lastName
          )
          .autocorrectionDisabled()
          .padding(10)
          .foregroundColor(.black)
          .font(Font.custom(weight: .bold, size: 20))
          .overlay(
            RoundedRectangle(cornerRadius: 14)
              .stroke(
                Color.textFieldBorderColor,
                lineWidth: 0.1
              )
          )
          .background(.white)
          .cornerRadius(14)
        }
      }
    }
    .sheet(isPresented: $viewModel.isImagePickerPresented) {
      ImagePicker(selectedImage: $viewModel.selectedImage)
    }
    .padding(.horizontal, 18)
  }
  
}
