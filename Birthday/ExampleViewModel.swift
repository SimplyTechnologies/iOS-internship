
import Combine
import Foundation

final class ContentViewModel: ObservableObject {
  
  @Published var users: [UserModel] = []
  @Published var error: RequestServiceError?
  
  let getUserUseCase: GetUsersUseCase
  private var cancelables = Set<AnyCancellable>()
  
  init(getUserUseCase: GetUsersUseCase) {
    self.getUserUseCase = getUserUseCase
  }
  
  func getUsers() {
    getUserUseCase.execute()
      .sink { [weak self] result in
        switch result {
        case .finished: break
        case .failure(let error):
          DispatchQueue.main.async {
            self?.error = error as? RequestServiceError
            print(error)
          }
        }
      } receiveValue: { [weak self] item in
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          
          self.users = item
        }
      }.store(in: &cancelables)
  }
  
}
