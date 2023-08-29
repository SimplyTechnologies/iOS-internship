
import Foundation

typealias SignInKeys = UserDefaultsKeys.SignIn

enum UserDefaultsKeys {
  
  enum SignIn: String {
    case isChecked = "isChecked"
    case email = "SignIn.Email"
    case password = "SignIn.Password"
    case token = "AccessToken"
    case tokenCreationDate = "TokenCreationDate"
  }
  
}
