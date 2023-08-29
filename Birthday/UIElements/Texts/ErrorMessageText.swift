
import SwiftUI

struct ErrorMessageText: View {
  
  // MARK: - Properties
  private let errorMessage: String
  
  // MARK: - Initializer
  init(_ errorMessage: String) {
    self.errorMessage = errorMessage
  }
  
  // MARK: - Body
  var body: some View {
    Text(errorMessage)
      .font(Font.custom(weight: .bold, size: 12))
      .foregroundColor(Color.errorColor)
      .multilineTextAlignment(.leading)
      .frame(height: 20, alignment: .leading)
      .offset(x: 5)
  }
  
}
