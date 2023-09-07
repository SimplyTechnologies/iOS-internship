
import Combine
import UIKit
import EventKit

class AddBirthdayViewModel: ObservableObject {
  
  @Published var isLoading: Bool = false
  @Published var isImagePickerPresented = false
  @Published var iSImagePickerPresented = false
  @Published var addImage: UIImage?
  private var eventStore = EKEventStore()
  private var authorizationStatus: EKAuthorizationStatus = EKEventStore.authorizationStatus(for: .event)
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let birthdaysRepository: BirthdaysRepository
  @Published var birthdayDetails: BirthdayModel
  var relations: [String] = [
    "Best Friend", "Mother", "Father", "Grandmother", "Grandfather", "Brother", "Sister", "Uncle", "Daughter"
  ]
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
        
        switch result {
        case .finished:
          break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] birthdayData in
        self?.isLoading = false
      }
      .store(in: &cancellables)
    
  }
  
  func addRepeatingEventToCalendar() {
    let event = EKEvent(eventStore: eventStore)
    event.title = "\(birthdayDetails.name)'s Birthday"
    event.calendar = eventStore.defaultCalendarForNewEvents
    event.notes = "Congratulate!!!"
    event.startDate = Calendar.current.date(
      from: birthdayDetails.date.get(
        .year,
        .month,
        .day
      )
    )!
    event.endDate = event.startDate.addingTimeInterval(
      86400
    )
    let recurrenceRule = EKRecurrenceRule(
      recurrenceWith: .yearly,
      interval: 1,
      end: nil
    )
    event.recurrenceRules = [recurrenceRule]
    do {
      try eventStore.save(event, span: .thisEvent)
      print("Repeating event saved to calendar")
    } catch {
      print("Error saving repeating event: \(error.localizedDescription)")
    }
  }
  
}
