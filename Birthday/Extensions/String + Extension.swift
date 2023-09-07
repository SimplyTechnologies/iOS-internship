
import Foundation.NSString

extension String {
  
  static let emptyString = ""
  
  func dateFromString() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return dateFormatter.date(from: self) ?? Date()
  }
  
  func isValidWith(regexType: Regexes) -> Bool {
    NSPredicate(
      format: Regexes.matchFormat,
      regexType.regex
    )
      .evaluate(with: self)
  }
  
  func checkMinimumLength(with value: Int) -> Bool {
    return self.count >= value
  }
  
  func cutTailIfLimitExceeded(with limit: Int) -> String {
    self.count > limit ? String(self.prefix(limit)) : self
  }
  
}
