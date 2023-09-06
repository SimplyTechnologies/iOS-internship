
import UIKit

extension UIApplication {
  
  func openPhoneURL(_ urlString: String) {
    if let phoneURL = URL(string: urlString), self.canOpenURL(phoneURL) {
      self.open(
        phoneURL,
        options: [:],
        completionHandler: nil
      )
    }
  }
  
}
