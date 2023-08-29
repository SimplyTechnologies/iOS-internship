
import UIKit

class AddBirthdayViewModel: ObservableObject {
  
  @Published var name: String = ""
  @Published var message: String = ""
  @Published var date = Date.now
  @Published var phoneNumber = ""
  @Published var isPhoneNumberValid = false
  @Published var phoneNumberInfo: (phoneNumber: String, isValid: Bool) = ("", false)
  
  @Published var addBirthdayViewModel =
    AddBirthdayModel(name: "Mesrop",
                     image: "profilePicture",
                     message: "bioooo",
                     phoneNumber: "+37493274722",
                     date: Date())
  
  func validatePhoneNumber(_ phoneNumber: String) -> Bool {
    let armenianRegex = "^\\+374\\d{8}$"
    let americanRegex = "^(\\d{3}-\\d{3}-\\d{4})|(\\(\\d{3}\\) \\d{3}-\\d{4})$"
    
    let armenianPredicate = NSPredicate(format: "SELF MATCHES %@", armenianRegex)
    let americanPredicate = NSPredicate(format: "SELF MATCHES %@", americanRegex)
    
    let isValid = armenianPredicate.evaluate(with: phoneNumber) || americanPredicate.evaluate(with: phoneNumber)
    
    phoneNumberInfo = (phoneNumber, isValid)
    
    return isValid
  }
  
}

