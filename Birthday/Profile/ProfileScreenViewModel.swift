
import Combine
import UIKit

class ProfileScreenViewModel: ObservableObject {
  
  @Published var user: UserModel = UserModel()
  @Published var isEditingModeOff = true
  @Published var showImagePicker = false
  @Published var selectedImage: UIImage?
  @Published var isImagePickerPresented = false
  @Published var isLoading: Bool = false
  
  var editableUser: UserModel = UserModel()
  
  private var cancellables: Set<AnyCancellable> = []
  private let userRepository: UserRepository
  
  private let storeManager = StoreManager.shared
  
  var fullName: String {
    user.firstName + " " + user.lastName
  }
  
  var areTextFieldsEdited: Bool {
    user.firstName != editableUser.firstName || user.lastName != editableUser.lastName || selectedImage != nil
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
        self?.editableUser = profileModel
      }
      .store(in: &cancellables)
  }
  
  func editProfileInfo(payload: Api.UpdateProfileInput) {
    userRepository.editProfileInfo(payload: payload)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
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
  
  func saveProfileInfo() {
    editProfileInfo(
      payload: Api.UpdateProfileInput(
        firstName: user.firstName ?? "",
        lastName: user.lastName ?? "",
        image: selectedImage?.base64 ?? nil
      )
    )
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.isEditingModeOff.toggle()
      self.getProfileInfo()
    }
  }
  
  func startToEdit() {
    isEditingModeOff.toggle()
    selectedImage = nil
  }
  
  func signOut() {
    storeManager.removeObject(for: UserDefaultsKeys.token.rawValue)
    storeManager.removeObject(for: UserDefaultsKeys.tokenCreationDate.rawValue)
    MainViewModel.loginStatusSubject.send(false)
  }
  
}
