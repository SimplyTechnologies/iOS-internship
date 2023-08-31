
import UIKit
import Combine

class ProfileScreenViewModel: ObservableObject {
  
  @Published var isEditingModeOff = true
  @Published var showImagePicker = false
  @Published var selectedImage: UIImage?
  @Published var isImagePickerPresented = false
  
  var fullName: String {
    user.firstName + " " + user.lastName
  }
  @Published var user = UserModel(
    firstName: "",
    lastName: "",
    email: "",
    image: ""
  )

  // TODO: will be changed
  var areTextFieldsEdited: Bool {
    user.firstName != myUser.firstName ||
    user.lastName != myUser.lastName
  }
  var myUser = UserModel(
    firstName: "",
    lastName: "",
    email: "",
    image: ""
  )
  
  private var cancellables: Set<AnyCancellable> = []
  private let birthdaysRepository: BirthdaysRepository
  
  init(birthdaysRepository: BirthdaysRepository) {
    self.birthdaysRepository = birthdaysRepository
  }
  
  func getProfile() {
    birthdaysRepository.getProfile()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        switch result {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] profileData in
        let model = UserModel(dto: profileData)
        self?.user = model
        self!.myUser = self!.user
      }
      .store(in: &cancellables)
  }
  func editFirstName(firstName: String) {
    myUser.firstName = firstName
  }
  func editLastName(lastName: String) {
    myUser.lastName = lastName
  }
  
}
