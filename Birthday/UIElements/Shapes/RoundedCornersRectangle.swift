
import SwiftUI

struct RoundedCornersRectangle: Shape {
  
  private let corners: UIRectCorner
  private let radius: CGFloat
  
  init(
    corners: UIRectCorner,
    radius: CGFloat
  ) {
    self.corners = corners
    self.radius = radius
  }
  
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
