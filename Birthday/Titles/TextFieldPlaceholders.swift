
enum TextFieldPlaceholders: Int, CaseIterable, Identifiable {
  
  var id: Int {
    self.rawValue
  }
  
  case name = 0
  case surname
  case email
  case password
  case repeatedPassword
  
  var description: String {
    switch self {
    case .name:
      return "Name"
    case .surname:
      return "Surname"
    case .email:
      return "Email"
    case .password:
      return "Password"
    case .repeatedPassword:
      return "Repeat password"
    }
  }
  
  static let signINCases = [Self.email,Self.password]
}
