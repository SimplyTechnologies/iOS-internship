
import UIKit

class BirthdayDetailsViewModel: ObservableObject {
  
  @Published var showAlert: Bool = false
  @Published var isShareSheetPresented = false
  @Published var isGeneratingMessage: Bool = false
  
  @Published var birthdayDetailsViewModel = BirthdayDetailsModel(
    name: "Axjik axjikyan",
    image: "profilePicture",
    relation: "Heru Barekam",
    message: "shnorhavor brats qez amenalavn u barin tangs",
    date: Date()
  )
  
  var date: Date = Date()
  var fullName: String {
    birthdayDetailsViewModel.name
  }
  
  var message: String {
    get {
      birthdayDetailsViewModel.message
    }
    set {
      birthdayDetailsViewModel.message = newValue
    }
  }
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter
  }()
  
}
