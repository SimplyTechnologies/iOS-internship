
import Apollo
import Combine

protocol UserRepository: GraphQLRepository {
  
  func getProfileInfo() -> AnyPublisher<Api.GetProfileQuery.Data.Profile, Error>
  func editProfileInfo(payload: Api.UpdateProfileInput) -> AnyPublisher<Api.UpdateProfileMutation.Data.UpdateProfile, Error>
  
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
  
}
