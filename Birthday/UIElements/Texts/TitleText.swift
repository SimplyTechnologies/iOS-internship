
import SwiftUI

struct TitleText: View {
  
  // MARK: - Properties
  let title: String
  let size: CGFloat
  
  // MARK: - Body
  var body: some View {
    Text(title)
      .font(
        Font.custom(
          weight: .bold,
          size: size
        )
      )
      .foregroundColor(Color.primaryColor)
  }
  
}
