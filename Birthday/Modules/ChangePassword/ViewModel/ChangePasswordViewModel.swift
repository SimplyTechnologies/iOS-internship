
import Combine
import Foundation

final class ChangePasswordViewModel: ObservableObject {
  
  @Published var isLoading: Bool = false
  @Published var errorMessage: String = ""
  
  var hasError: Bool = false
  
  private let userRepository: UserRepository
  private var cancellables: Set<AnyCancellable> = []
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func changePassword(
    oldPassword: String,
    newPassword: String
  ) {
    self.isLoading = true
    userRepository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword
    )
    .receive(on: DispatchQueue.main)
    .sink { [weak self] result in
      self?.isLoading = false
      switch result {
      case .finished: break
      case .failure(let error):
        print(error)
        self?.hasError = true
        self?.errorMessage = error.localizedDescription
      }
    } receiveValue: { pass in
      print(pass.id)
    }
    .store(in: &cancellables)
  }
}
