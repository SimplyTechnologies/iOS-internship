
import SwiftUI

struct FullRoundedButtonStyle: ButtonStyle {
  
  // MARK: - Properties
  let isDisable: Bool
  
  // MARK: - Functions
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .font(Font.custom(weight: .bold, size: 15))
      .foregroundColor(
        isDisable ? Color.primaryColor : Color.secondaryColor
      )
      .frame(height: 45)
      .frame(maxWidth: .infinity)
      .background(
        isDisable ? Color.secondaryColor : Color.primaryColor
      )
      .cornerRadius(22.5)
      .disabled(isDisable)
  }
  
}
