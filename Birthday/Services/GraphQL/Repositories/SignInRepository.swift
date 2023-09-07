
import Combine

protocol SignInRepository: GraphQLRepository {
  
  func signIn(payload: Api.LoginInput) -> AnyPublisher<Api.LoginMutation.Data.Login, Error>
  func resetPasswordEmail(email: String) -> AnyPublisher<Api.ResetPasswordEmailMutation.Data.ResetPasswordEmail, Error>
  func resetPassword(payload: Api.ResetPasswordInput) -> AnyPublisher<Api.ResetPasswordMutation.Data.ResetPassword, Error>

}

final class SignInRepositoryImpl: SignInRepository {
  
  func signIn(payload: Api.LoginInput) -> AnyPublisher<Api.LoginMutation.Data.Login, Error> {
    return request(mutation: Api.LoginMutation(loginInput: payload))
      .compactMap { $0.login }
      .eraseToAnyPublisher()
  }
  
  func resetPasswordEmail(email: String) -> AnyPublisher<Api.ResetPasswordEmailMutation.Data.ResetPasswordEmail, Error> {
    return request(mutation: Api.ResetPasswordEmailMutation(email: email))
      .compactMap { $0.resetPasswordEmail }
      .eraseToAnyPublisher()
  }
  
  func resetPassword(payload: Api.ResetPasswordInput) -> AnyPublisher<Api.ResetPasswordMutation.Data.ResetPassword, Error> {
    return request(mutation: Api.ResetPasswordMutation(resetPasswordInput: payload))
      .compactMap { $0.resetPassword }
      .eraseToAnyPublisher()
  }
  
}
