
import SwiftUI

extension Font {
  
  enum Karma: String {
    case bold = "Karma-Bold"
    case light = "Karma-Light"
    case medium = "Karma-Medium"
    case regular = "Karma-Regular"
    case semiBold = "Karma-SemiBold"
  }
  
  static func custom(weight: Font.Karma, size: CGFloat) -> Font {
    Font.custom(weight.rawValue, size: size)
  }
  
}
