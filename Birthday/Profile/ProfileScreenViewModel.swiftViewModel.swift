
import UIKit

class ProfileScreenViewModel: ObservableObject {
  
  @Published var isEditingModeOff = true
  @Published var showImagePicker = false
  @Published var selectedImage: UIImage? = nil
  @Published var isImagePickerPresented = false
  
  var fullName: String {
    user.firstName + " " + user.lastName
  }
  
  // TODO: will be changed
  var areTextFieldsEdited: Bool {
    user.firstName != "Shirley" || user.lastName != "Shirleyyan"
  }
  
  
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
