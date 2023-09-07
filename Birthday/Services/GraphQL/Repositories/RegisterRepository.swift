

import Combine

protocol RegisterRepository: GraphQLRepository {
  func signUp(payload: Api.SignUpInput) -> AnyPublisher<Api.SignUpMutation.Data.SignUp, Error>
}

final class RegisterRepositoryImpl: RegisterRepository {
  func signUp(payload: Api.SignUpInput) -> AnyPublisher<Api.SignUpMutation.Data.SignUp, Error> {
    return request(mutation: Api.SignUpMutation(signUpInput: payload))
      .compactMap { $0.signUp }
      .eraseToAnyPublisher()
  }
}
