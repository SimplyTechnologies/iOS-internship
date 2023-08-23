
import SwiftUI

enum TabItem {
  
  case home
  case shop
  case profile
  
  var unSelectedImage: Image {
    switch self {
    case .home:
      return Image("Home")
    case .shop:
      return Image("Shops")
    case .profile:
      return Image("Profile")
    }
  }
  
  var selectedImage: Image {
    switch self {
    case .home:
      return Image("Home-selected")
    case .shop:
      return Image("Shops-selected")
    case .profile:
      return Image("Profile-selected")
    }
  }
  
}
