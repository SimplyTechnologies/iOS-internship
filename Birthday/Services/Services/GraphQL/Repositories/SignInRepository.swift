
import Combine

protocol SignInRepository: GraphQLRepository {
  
  func signIn(payload: Api.LoginInput) -> AnyPublisher<Api.LoginMutation.Data.Login, Error>
  
}

final class SignInRepositoryImpl: SignInRepository {
  
  func signIn(payload: Api.LoginInput) -> AnyPublisher<Api.LoginMutation.Data.Login, Error> {
    return request(mutation: Api.LoginMutation(loginInput: payload))
      .compactMap { $0.login }
      .eraseToAnyPublisher()
  }
  
}
