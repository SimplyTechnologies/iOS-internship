
import Foundation

extension Date {
  
  func stringFromDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM.dd.yyyy"
    return dateFormatter.string(from: self)
  }
  
}
