
enum NetworkError: Error {
  
  case validationFailure
  case registrationError
  
  var description: String {
    switch self {
    case .validationFailure:
      // swiftlint:disable:next line_length
      return "We could not find an account with a set email or password. Please check the entered credentials"
    case .registrationError:
      return "Sorry, an error occurred registering your account, please try again."
    }
  }
  
}
