
import Combine
import UIKit

class AddBirthdayViewModel: ObservableObject {
  
  @Published var isLoading: Bool = false
  @Published var isImagePickerPresented = false
  @Published var iSImagePickerPresented = false
  @Published var addImage: UIImage?

  private var cancellables: Set<AnyCancellable> = []
  
  private let birthdaysRepository: BirthdaysRepository
  var birthdayDetails: BirthdayModel
  
  init(
    birthdayDetails: BirthdayModel,
    birthdaysRepository: BirthdaysRepository
  ) {
    self.birthdayDetails = birthdayDetails
    self.birthdaysRepository = birthdaysRepository
  }
  
  func addBirthday(by input: Api.CreateBirthdayInput) {
    self.isLoading = true
    birthdaysRepository.addBirthday(by: input)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] birthdayData in
//        print(birthdayData)
      }
      .store(in: &cancellables)
  }
  
}
