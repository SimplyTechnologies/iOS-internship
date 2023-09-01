
import SwiftUI

struct PartiallyRoundedButtonStyle: ButtonStyle {
  
  private let corners: UIRectCorner
  private let backgroundColor: Color
  private let foregroundColor: Color
  
  init(
    corners: UIRectCorner,
    backgroundColor: Color,
    foregroundColor: Color
  ) {
    self.corners = corners
    self.backgroundColor = backgroundColor
    self.foregroundColor = foregroundColor
  }
  
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
