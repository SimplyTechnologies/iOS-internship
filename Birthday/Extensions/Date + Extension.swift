
import Foundation.NSDate

extension Date {
  
  func stringFromDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM.dd.yyyy"
    return dateFormatter.string(from: self)
  }
  
  func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
    return calendar.dateComponents(Set(components), from: self)
  }
  
}
