
import Combine

protocol BirthdaysRepository: GraphQLRepository {
  
  func getBirthdays() -> AnyPublisher<[Api.GetBirthdaysQuery.Data.Birthday], Error>
  func deleteBirthday(by id: Int) -> AnyPublisher<Api.DeleteBirthdayMutation.Data.DeleteBirthday, Error>
  func getProfile() -> AnyPublisher<Api.GetProfileQuery.Data.Profile, Error>
}

final class BirthdaysRepositoryImpl: BirthdaysRepository {
  
  func getBirthdays() -> AnyPublisher<[Api.GetBirthdaysQuery.Data.Birthday], Error> {
    return request(query: Api.GetBirthdaysQuery())
      .compactMap { $0.birthdays }
      .eraseToAnyPublisher()
  }
  
  func deleteBirthday(by id: Int) -> AnyPublisher<Api.DeleteBirthdayMutation.Data.DeleteBirthday, Error> {
    return request(mutation: Api.DeleteBirthdayMutation(id: id))
      .compactMap { $0.deleteBirthday }
      .eraseToAnyPublisher()
  }
  
  func getProfile() -> AnyPublisher<Api.GetProfileQuery.Data.Profile, Error> {
    return request(query: Api.GetProfileQuery())
      .compactMap { $0.profile }
      .eraseToAnyPublisher()
  }
  
}
