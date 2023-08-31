
import SwiftUI

struct PartiallyRoundedButtonStyle: ButtonStyle {
  
  // MARK: - Properties
  let corners: UIRectCorner
  let backgroundColor: Color
  let foregroundColor: Color
  
  // MARK: - Functions
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .font(Font.custom(weight: .bold, size: 20))
      .foregroundColor(foregroundColor)
      .frame(height: 51)
      .frame(maxWidth: .infinity)
      .background {
        RoundedCornersRectangle(
          corners: corners,
          radius: 42
        )
        .fill(backgroundColor)
      }
  }
  
}
