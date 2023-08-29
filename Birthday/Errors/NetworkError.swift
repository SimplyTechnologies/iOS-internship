
enum NetworkError: Error {
  
  case validationFailure
  
  var description: String {
    switch self {
    case .validationFailure:
      return "We could not find an account with a set email or password. Please check the entered credentials"
    }
  }
  
}
