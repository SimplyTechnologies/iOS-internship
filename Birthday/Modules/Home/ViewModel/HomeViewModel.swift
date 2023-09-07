
import Combine
import Foundation

final class HomeViewModel: ObservableObject {
  
  static var updateStatusSubject = PassthroughSubject<Void, Never>()
  
  @Published var birthdays: [BirthdayModel] = []
  @Published var isLoading: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  private let birthdayRepository: BirthdaysRepository
  
  private var updateStatusPublisher: AnyPublisher<Void, Never> = {
    updateStatusSubject.eraseToAnyPublisher()
  }()
  
  init(birthdayRepository: BirthdaysRepository) {
    self.birthdayRepository = birthdayRepository
    getBirthdays()
    
    updateStatusPublisher.sink { _ in
      self.getBirthdays()
    }
    .store(in: &cancellables)
  }
  
  func getBirthdays() {
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
        self?.birthdays.append(contentsOf: birthdayModels)
      }
      .store(in: &cancellables)
  }
  
}
