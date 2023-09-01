
import Combine
import UIKit

class ProfileScreenViewModel: ObservableObject {
  
  @Published var user: UserModel = UserModel()
  @Published var isEditingModeOff = true
  @Published var showImagePicker = false
  @Published var selectedImage: UIImage?
  @Published var isImagePickerPresented = false
  @Published var isLoading: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  private let userRepository: UserRepository
  
  var fullName: String {
    user.firstName + " " + user.lastName
  }
  
  var areTextFieldsEdited: Bool {
    user.firstName != "Shirley" || user.lastName != "Shirleyyan"
  }
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
    getProfileInfo()
  }
  
  func getProfileInfo() {
    self.isLoading = true
    userRepository.getProfileInfo()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] profileData in
        let profileModel = UserModel(dto: profileData)
        self?.user = profileModel
      }
      .store(in: &cancellables)
  }
  
  func editProfileInfo(payload: Api.UpdateProfileInput) {
    self.isLoading = true
    userRepository.editProfileInfo(payload: payload)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished: break
        case .failure(let error):
          print(error.localizedDescription)
        }
      } receiveValue: { [weak self] editProfile in
        print(editProfile)
      }
      .store(in: &cancellables)
  }
  
}
