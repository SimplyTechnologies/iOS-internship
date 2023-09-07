
import UIKit

extension UIImage {
  func toString() -> String? {
    
    let pngData = self.pngData()
    
    //let jpegData = self.jpegData(compressionQuality: 0.75)
    
    return pngData?.base64EncodedString(options: .lineLength64Characters)
  }
}
