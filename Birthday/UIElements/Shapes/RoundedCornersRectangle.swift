
import SwiftUI

struct RoundedCornersRectangle: Shape {
  
  // MARK: - Properties
  private let corners: UIRectCorner
  private let radius: CGFloat
  
  // MARK: - Initializer
  init(
    corners: UIRectCorner,
    radius: CGFloat
  ) {
    self.corners = corners
    self.radius = radius
  }
  
  // MARK: - Functions
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(
        width: radius,
        height: radius
      )
    )
    
    return Path(path.cgPath)
  }
  
}
