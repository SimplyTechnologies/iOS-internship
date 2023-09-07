
import SwiftUI

struct BirthdayDetailsScreen: View {
  
  @ObservedObject var viewModel: BirthdayDetailsViewModel
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      ScrollView {
        VStack {
          HStack {
            Spacer()
            Button {
              viewModel.showAlert.toggle()
            } label: {
              Image(systemName: "xmark.bin")
                .foregroundColor(.black)
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
              Alert(
                title: Text(
                  "Are you sure you want to delete this birthday information?"
                ),
                primaryButton: .destructive(
                  Text("Yes")
                ) {
                  viewModel.deleteBirthday(by: viewModel.birthdayDetails.id)
                  presentationMode.wrappedValue.dismiss()
                  
                },
                secondaryButton: .default(
                  Text("No")
                )
              )
            }
          }
          .padding(.horizontal)
          imageView
            .padding()
          
          Text(viewModel.birthdayDetails.name)
            .fontWeight(.bold)
            .padding(1)
            .foregroundColor(.black)
          Text(
            viewModel.birthdayDetails.date.stringFromDate()
          )
          .foregroundColor(.black)
          HStack {
            Text("Relationship :")
              .foregroundColor(.black)
            Text(viewModel.birthdayDetails.relation)
              .padding(10)
              .background(Color.white)
              .foregroundColor(.black)
              .cornerRadius(10)
          }
          .padding(1)
          HStack {
            Text("Zodiac Sign : ")
            Text(viewModel.zodiacSign())
              .foregroundColor(.primaryColor)
          }
          if viewModel.isGeneratingMessage {
            GenerateMessageView(viewModel: viewModel)
          } else {
            Spacer()
            Button {
              viewModel.isGeneratingMessage.toggle()
            } label: {
              Text("Generate Message")
                .padding(.horizontal, 28)
                .padding(.vertical, 8)
                .foregroundColor(.white)
                .background(Color.primaryColor)
                .cornerRadius(16)
            }
            .padding()
          }
        }
        .animation(
          .easeInOut,
          value: viewModel.isGeneratingMessage
        )
      }
    }
    .navigationBar()
    .font(Font.custom(weight: .bold, size: 20))
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
  }
  
  @ViewBuilder
  private var imageView: some View {
    if let imageData = viewModel.birthdayDetails.image,
       !imageData.isEmpty,
       let data = Data(base64Encoded: imageData),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .frame(width: 150, height: 150)
        .cornerRadius(75)
    } else {
      ZStack {
        Color.secondaryColor
        Image(systemName: "person")
          .resizable()
          .frame(width: 80, height: 80)
          .foregroundColor(Color.white)
      }
      .frame(width: 150, height: 150)
      .cornerRadius(75)
    }
  }
}

struct BirthdayDetailsScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    BirthdayDetailsScreen(
      viewModel: BirthdayDetailsViewModel(
        birthdayDetails: BirthdayModel(
          id: 1,
          userId: 1,
          name: "M",
          image: "",
          relation: "",
          message: "",
          date: Date(),
          upcomingBirthday: Date(),
          upcomingAge: 1,
          createdAt: Date(),
          updatedAt: Date()
        ),
        birthdaysRepository: BirthdaysRepositoryImpl()
      )
    )
  }
  
}
