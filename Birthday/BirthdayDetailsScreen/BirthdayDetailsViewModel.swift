
import Combine
import Foundation

class BirthdayDetailsViewModel: ObservableObject {
  
  @Published var showAlert: Bool = false
  @Published var isShareSheetPresented = false
  @Published var isGeneratingMessage: Bool = false
  @Published var isLoading: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let birthdaysRepository: BirthdaysRepository
  var birthdayDetails: BirthdayModel
  var date: Date = Date()
  
  init(
    birthdayDetails: BirthdayModel,
    birthdaysRepository: BirthdaysRepository
  ) {
    self.birthdayDetails = birthdayDetails
    self.birthdaysRepository = birthdaysRepository
  }
  
  func deleteBirthday(by id: Int) {
    self.isLoading = true
    birthdaysRepository.deleteBirthday(by: id)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { deleted in
        print(deleted)
        HomeViewModel.updateStatusSubject.send()
      }
      .store(in: &cancellables)
  }
  
  func zodiacSign() -> String {
    let calendar = Calendar.current
    let month = calendar.component(.month, from: birthdayDetails.date)
    let day = calendar.component(.day, from: birthdayDetails.date)
    
    switch (month, day) {
    case (3, 21...31), (4, 1...19):
      return "Aries"
    case (4, 20...30), (5, 1...20):
      return "Taurus"
    case (5, 21...31), (6, 1...20):
      return "Gemini"
    case (6, 21...30), (7, 1...22):
      return "Cancer"
    case (7, 23...31), (8, 1...22):
      return "Leo"
    case (8, 23...31), (9, 1...22):
      return "Virgo"
    case (9, 23...30), (10, 1...22):
      return "Libra"
    case (10, 23...31), (11, 1...21):
      return "Scorpio"
    case (11, 22...30), (12, 1...21):
      return "Sagittarius"
    case (12, 22...31), (1, 1...19):
      return "Capricorn"
    case (1, 20...31), (2, 1...18):
      return "Aquarius"
    case (2, 19...31), (3, 1...20):
      return "Pisces"
    default:
      return ""
    }
  }
  
}
