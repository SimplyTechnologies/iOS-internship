
import SwiftUI

struct ToastText: View {
  
  private let errorMessage: String
  
  init(
    _ errorMessage: String
  ) {
    self.errorMessage = errorMessage
  }
  
  var body: some View {
    Text(errorMessage)
      .font(Font.custom(weight: .bold, size: 16))
      .foregroundColor(Color.primaryColor)
      .multilineTextAlignment(.center)
      .padding(.all, 15)
      .background(Color.backgroundColor)
      .cornerRadius(15)
      .shadow(color: .gray.opacity(0.6), radius: 15)
      .padding(.horizontal)
      .transition(
        .asymmetric(
          insertion: .move(edge: .bottom),
          removal: .opacity
        )
      )
  }
  
}
