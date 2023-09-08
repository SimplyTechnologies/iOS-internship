
enum LocalError: Error {
    
  // MARK: - Empty error
  case emptyName
  case emptySurname
  case emptyEmail
  case emptyPassword
  
  // MARK: - Short error
  case shortName
  case shortSurname
  case shortPassword
  
  // MARK: - Invalid error
  case invalidName
  case invalidSurname
  case invalidEmail
  case invalidPassword
  
  // MARK: - Match error
  case passwordMatch
  
  // MARK: - Description
  var description: String {
    switch self {
      
      // MARK: - Empty error
    case .emptyName:
      return "Name is required"
    case .emptySurname:
      return "Surname is required"
    case .emptyEmail:
      return "Email address is required"
    case .emptyPassword:
      return "Password is required"
      
      // MARK: - Short error
    case .shortName, .shortSurname:
      return "Too short. Use at least 2 characters"
    case .shortPassword:
      return "Too short. Use at least 8 characters"
      
      // MARK: - Invalid error
    case .invalidName:
      return "Enter only 'a-z, A-Z, -' symbols"
    case .invalidSurname:
      return "Enter only 'a-z, A-Z, -' symbols"
    case .invalidEmail:
      return "Please enter a valid email address"
    case .invalidPassword:
      return "The password contains forbidden characters"
      
      // MARK: - Match error
    case .passwordMatch:
      return "The password does not match"
    }
  }
  
}
