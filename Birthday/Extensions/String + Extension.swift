
import Foundation

extension String {
  
  func dateFromString() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return dateFormatter.date(from: self) ?? Date()
  }
  
}
