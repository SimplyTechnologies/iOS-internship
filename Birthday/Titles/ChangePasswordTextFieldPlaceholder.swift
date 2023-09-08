
enum ChangePasswordTextFieldPlaceholder {

  case oldPassword
  case newPassword
  case repeatNewPassword
  
  var description: String {
    switch self {
    case .oldPassword:
      return "Old Password"
    case .newPassword:
      return "New Password"
    case .repeatNewPassword:
      return "Repeat New Password"
    }
  }
  
}
