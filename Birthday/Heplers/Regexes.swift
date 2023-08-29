
enum Regexes {
  
  static let matchFormat = "SELF MATCHES %@"
  
  case name
  case email
  case password
  
  var regex: String {
    switch self {
    case .name:
      return "[a-zA-Z-]{2,20}"
    case .email:
      return "[a-zA-Z0-9.-_]+@[a-zA-Z0-9.-_]+\\.[a-zA-z]{2,}"
    case .password:
      return "[a-zA-Z0-9.-_]{6,32}"
    }
  }
  
}
