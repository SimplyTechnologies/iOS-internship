
enum NetworkError: Error {
  
  case authorizationFailure
  case registrationError
  case userExists
  
  var description: String {
    switch self {
    case .authorizationFailure:
      // swiftlint:disable:next line_length
      return "We could not find an account with a set email or password. Please check the entered credentials"
    case .registrationError:
      return "Sorry, an error occurred registering your account, please try again."
    case .userExists:
      return "User Exist with provided email"
    }
  }
  
}
