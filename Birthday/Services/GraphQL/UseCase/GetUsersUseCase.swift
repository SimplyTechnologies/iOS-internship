
import Combine

class GetUsersUseCase {
  
  let usersReopsitory: UsersRepository
  
  init(usersReopsitory: UsersRepository) {
    self.usersReopsitory = usersReopsitory
  }
  
  func execute() -> AnyPublisher<[UserModel], Error> {
    usersReopsitory.getUsers()
      .map { item in item.map { UserModel(dto: $0) }}
      .eraseToAnyPublisher()
  }
  
}

struct UserModel {
  
  let id: String
  let lastName: String
  let email: String
  let firstName: String
  
  init(dto: GetUsersQuery.Data.User) {
    self.id = dto.id
    self.lastName = dto.lastName
    self.email = dto.email
    self.firstName = dto.firstName
  }
  
}
