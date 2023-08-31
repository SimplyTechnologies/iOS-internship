
import SwiftUI

struct GenerateMessageView: View {
  
  @ObservedObject var viewModel: BirthdayDetailsViewModel
  
  var body: some View {
    
    VStack(spacing: 0) {
      TextEditor(text: $viewModel.birthdayDetails.message)
        .colorMultiply(Color.backgroundColor)
        .cornerRadius(10)
        .padding(
          EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 0,
            trailing: 16
          )
        )
      
      HStack {
        Spacer()
        Button(action: {
          presentShareSheet()
        }, label: {
          Text("Send")
            .padding()
            .background(Color.backgroundColor)
            .foregroundColor(Color.primaryColor)
            .cornerRadius(10)
        })
        .padding()
      }
    }
    .frame(height: 250)
    .background(Color.white)
    .cornerRadius(10)
    .padding()
    
  }
  
  private func presentShareSheet() {
    let activityItems = [viewModel.birthdayDetails.message]
    let activityViewController = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: nil
    )
    if let windowScene = UIApplication.shared.connectedScenes
      .filter({ $0.activationState == .foregroundActive })
      .first as? UIWindowScene {
      if let mainWindow = windowScene.windows.first {
        mainWindow.rootViewController?.present(
          activityViewController,
          animated: true,
          completion: nil
        )
      }
    }
  }
  
}

struct ActivityViewController: UIViewControllerRepresentable {
  
  var activityItems: [Any]
  
  func makeUIViewController(context: Context) -> UIActivityViewController {
    let activityViewController = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: nil
    )
    return activityViewController
  }
  
  func updateUIViewController(
    _ uiViewController: UIActivityViewController,
    context: Context
  ) {
    
  }
  
}
