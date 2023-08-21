
import Combine

protocol UsersRepository: GraphQLRepository {
  
  func getUsers() -> AnyPublisher<[GetUsersQuery.Data.User], Error>
  
}

final class UsersRepositoryImpl: UsersRepository {
  
  func getUsers() -> AnyPublisher<[GetUsersQuery.Data.User], Error> {
    request(query: GetUsersQuery())
      .compactMap { $0.users }
      .eraseToAnyPublisher()
    
  }
  
}
