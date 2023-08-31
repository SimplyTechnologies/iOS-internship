
import SwiftUI

struct RoundedButton: View {
  
  // MARK: - Properties
  private let title: String
  private let action: () -> Void
  private var isDisable: Bool
  
  // MARK: - Initializer
  init(
    title: String,
    isDisable: Bool,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.isDisable = isDisable
    self.action = action
  }
  
  // MARK: - Body
  var body: some View {
    NavigationLink(destination: EmptyView()) {
      EmptyView()
        .background(.blue)
    }
    .foregroundColor(
      isDisable ? Color.primaryColor : Color.secondaryColor
    )
    .font(
      Font.custom(weight: .bold, size: 15)
    )
    .frame(height: 45)
    .frame(maxWidth: .infinity)
    .background(
      isDisable ? Color.secondaryColor : Color.primaryColor
    )
    
    .onTapGesture {
      action()
    }
  }
  
}
