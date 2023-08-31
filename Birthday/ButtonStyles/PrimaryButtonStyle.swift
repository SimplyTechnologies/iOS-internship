
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  
  @Environment(\.isEnabled) var isEnabled
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(
        Color(
          red: 0.59,
          green: 0.24,
          blue: 0.35
        )
        .opacity(isEnabled ? 1 : 0.5)
      )
      .frame(
        maxWidth: .infinity
      )
      .frame(height: 50)
      .background(backgroundColor(with: configuration))
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
  
  private func backgroundColor(with configuration: Configuration) -> Color {
    if configuration.isPressed {
      return Color(.white).opacity(0.7)
    } else if !isEnabled {
      return Color(.white).opacity(0.5)
    } else {
      return Color(.white)
    }
  }
  
}
