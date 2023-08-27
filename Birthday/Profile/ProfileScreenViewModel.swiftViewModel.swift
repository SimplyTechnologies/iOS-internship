
import Combine
import Foundation

class ProfileViewModel: ObservableObject {
  
  @Published var user =
    UserModel(
      firstName: "Shirley",
      lastName: "Shirleyyan",
      email: "shirleyjan@shirley.ru",
      image: "shirley.png"
    )
  func editFirstName() {
    
  }
  func editLastName() {
    
  }
  func editImage() {
    
  }
  
}
