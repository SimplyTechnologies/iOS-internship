
import SwiftUI

struct BirthdayDetailsScreen: View {
  
  @ObservedObject var viewModel = BirthdayDetailsViewModel()
  
  var body: some View {
    
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      ScrollView {
        VStack {
          HStack {
            Spacer()
            Image("LogoBirthApp")
              .padding()
              .foregroundColor(.black)
          }
          HStack {
            Spacer()
            Button {
              viewModel.showAlert.toggle()
            } label: {
              Image(systemName: "xmark.bin")
                .foregroundColor(.black)
            }
            .alert(isPresented: $viewModel.showAlert) {
              Alert(title: Text("Are you sure you want to delete this birthday information?"), primaryButton: .destructive(Text("Yes")), secondaryButton: .default(Text("No")))
            }
          }
          .padding(.horizontal)
          Image(viewModel.birthdayDetailsViewModel.image).resizable()
            .frame(width: 150, height: 150)
            .padding()
          Text(viewModel.fullName)
            .fontWeight(.bold)
            .padding(1)
            .foregroundColor(.black)
          Text(viewModel.dateFormatter.string(from: viewModel.date))
            .foregroundColor(.black)
          HStack {
            Text("Relationship :")
              .foregroundColor(.black)
            Text(viewModel.birthdayDetailsViewModel.relation)
              .padding(10)
              .background(
                Color.white
              )
              .foregroundColor(.black)
              .cornerRadius(10)
          }
          .padding(1)
          if viewModel.isGeneratingMessage {
            GenerateMessageView(viewModel: viewModel)
          }
          if !viewModel.isGeneratingMessage {
            Spacer()
              .frame(minHeight: 270)
          }
          Button("Generate Message") {
            viewModel.isGeneratingMessage.toggle()
          }
          .buttonStyle(PrimaryButtonStyle())
          .padding()
        }
        .animation(.easeInOut, value: viewModel.isGeneratingMessage)
      }
    }
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
  }
  
}

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

struct BirthdayDetailsScreen_Previews: PreviewProvider {
  
  static var previews: some View {
    BirthdayDetailsScreen()
  }
  
}
