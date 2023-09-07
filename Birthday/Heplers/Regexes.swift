
enum Regexes {
  
  #warning("Сделать regex для пароля на содержание специального символа")
  static let matchFormat = "SELF MATCHES %@"
  static let containtFormat = "SELF CONTAINS %@"
  
  case name
  case email
  case password
  case specialSymbol
  
  var regex: String {
    switch self {
    case .name:
      return "[a-zA-Z-]{2,20}"
    case .email:
      return "[a-zA-Z0-9.-_]+@[a-zA-Z0-9.-_]+\\.[a-zA-z]{2,60}"
    case .password:
      return "[a-zA-Z0-9!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]{8,}"
    case .specialSymbol:
      return ".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*"
    }
  }
  
}
