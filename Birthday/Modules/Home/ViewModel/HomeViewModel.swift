
import Combine
import Foundation

final class HomeViewModel: ObservableObject {
  
  @Published var birthdays: [BirthdayModel] = []
  @Published var isLoading: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  private let birthdayRepository: BirthdaysRepository
  
  init(birthdayRepository: BirthdaysRepository) {
    self.birthdayRepository = birthdayRepository
    getBirthdays()
  }
  
  private func getBirthdays() {
    self.isLoading = true
    birthdayRepository.getBirthdays()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] birthdayData in
        let birthdayModels = birthdayData.map { BirthdayModel(dto: $0) }
        self?.birthdays = birthdayModels
      }
      .store(in: &cancellables)
  }
  
}
