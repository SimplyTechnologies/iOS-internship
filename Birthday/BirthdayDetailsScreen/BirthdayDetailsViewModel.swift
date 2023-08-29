
import Foundation
import Combine

class BirthdayDetailsViewModel: ObservableObject {
  
  @Published var showAlert: Bool = false
  @Published var isShareSheetPresented = false
  @Published var isGeneratingMessage: Bool = false
  
  private let birthdaysRepository: BirthdaysRepository
  
  var birthdayDetails: BirthdayModel
  
  var date: Date = Date()
  
  var message: String {
    get {
      birthdayDetails.message
    }
    set {
//      birthdayDetails.message = newValue
    }
  }
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter
  }()
  
  init(birthdayDetails: BirthdayModel,
       birthdaysRepository: BirthdaysRepository) {
    self.birthdayDetails = birthdayDetails
    self.birthdaysRepository = birthdaysRepository
  }
  
  func deleteBirthday(by id: Int) {
    birthdaysRepository.deleteBirthday(by: id)
    
  }
}
