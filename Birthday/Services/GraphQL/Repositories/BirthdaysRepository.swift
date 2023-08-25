
import Combine

protocol BirthdaysRepository: GraphQLRepository {
  
  func getBirthdays() -> AnyPublisher<[Api.GetBirthdaysQuery.Data.Birthday], Error>
  
}

final class BirthdaysRepositoryImpl: BirthdaysRepository {
  
  func getBirthdays() -> AnyPublisher<[Api.GetBirthdaysQuery.Data.Birthday], Error> {
    return request(query: Api.GetBirthdaysQuery())
      .compactMap { $0.birthdays }
      .eraseToAnyPublisher()
  }
  
}
