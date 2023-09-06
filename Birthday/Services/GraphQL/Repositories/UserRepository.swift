
import Apollo
import Combine

protocol UserRepository: GraphQLRepository {
  
  func getProfileInfo() -> AnyPublisher<Api.GetProfileQuery.Data.Profile, Error>
  func editProfileInfo(payload: Api.UpdateProfileInput) -> AnyPublisher<Api.UpdateProfileMutation.Data.UpdateProfile, Error>
  func changePassword(oldPassword: String, newPassword: String) -> AnyPublisher<Api.ChangePasswordMutation.Data.ChangePassword, Error>

}

final class UserRepositoryImpl: UserRepository {
  
  func getProfileInfo() -> AnyPublisher<Api.GetProfileQuery.Data.Profile, Error> {
    request(query: Api.GetProfileQuery())
      .compactMap { $0.profile }
      .eraseToAnyPublisher()
  }

  func editProfileInfo(payload: Api.UpdateProfileInput) -> AnyPublisher<Api.UpdateProfileMutation.Data.UpdateProfile, Error> {
    request(mutation: Api.UpdateProfileMutation(updateProfileInput: payload))
      .compactMap { $0.updateProfile }
      .eraseToAnyPublisher()
  }
  
  func changePassword(oldPassword: String, newPassword: String) -> AnyPublisher<Api.ChangePasswordMutation.Data.ChangePassword, Error> {
    request(mutation: Api.ChangePasswordMutation(oldPassword: oldPassword, newPassword: newPassword))
      .compactMap { $0.changePassword }
      .eraseToAnyPublisher()
  }
  
}
