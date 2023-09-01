
import SwiftUI

struct ErrorMessageText: View {
  
  private let errorMessage: String
  
  init(
    _ errorMessage: String
  ) {
    self.errorMessage = errorMessage
  }
  
  var body: some View {
    Text(errorMessage)
      .font(Font.custom(weight: .bold, size: 12))
      .foregroundColor(Color.errorColor)
      .multilineTextAlignment(.leading)
      .frame(height: 20, alignment: .leading)
      .offset(x: 5)
  }
  
}
