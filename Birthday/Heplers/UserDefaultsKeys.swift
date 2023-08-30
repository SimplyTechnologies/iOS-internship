
import Foundation

typealias SignInKeys = UserDefaultsKeys.SignIn

enum UserDefaultsKeys {
  
  enum SignIn: String {
    
    case isChecked = "isChecked"
    case isLogged = "isLogged"
    case email = "email"
    case token = "token"
    case tokenCreationDate = "tokenCreationDate"
    
  }
  
}
