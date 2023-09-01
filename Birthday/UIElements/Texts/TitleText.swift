
import SwiftUI

struct TitleText: View {
  
  private let title: String
  private let size: CGFloat
  
  init(
    title: String,
    size: CGFloat
  ) {
    self.title = title
    self.size = size
  }
  
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
