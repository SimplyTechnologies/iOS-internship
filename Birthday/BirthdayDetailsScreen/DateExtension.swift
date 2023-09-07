
import UIKit

extension Date {
  
  func dateFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    return dateFormatter.string(from: self)
  }
  
}
