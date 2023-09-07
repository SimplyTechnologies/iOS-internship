// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Mutation: MockObject {
  public static let objectType: Object = Api.Objects.Mutation
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Mutation>>

  public struct MockFields {
    @Field<UserFavoriteShop>("addShopToFavorite") public var addShopToFavorite
<<<<<<< HEAD
    @Field<User>("changePassword") public var changePassword
    @Field<Birthday>("deleteBirthday") public var deleteBirthday
    @Field<AccessToken>("login") public var login
    @Field<UserFavoriteShop>("removeShopFromFavorite") public var removeShopFromFavorite
=======
    @Field<Birthday>("deleteBirthday") public var deleteBirthday
    @Field<AccessToken>("login") public var login
    @Field<UserFavoriteShop>("removeShopFromFavorite") public var removeShopFromFavorite
    @Field<User>("signUp") public var signUp
>>>>>>> fbcba15 (Added new functionality, fixed bugs, added UI elements)
    @Field<User>("updateProfile") public var updateProfile
  }
}

public extension Mock where O == Mutation {
  convenience init(
    addShopToFavorite: Mock<UserFavoriteShop>? = nil,
<<<<<<< HEAD
    changePassword: Mock<User>? = nil,
    deleteBirthday: Mock<Birthday>? = nil,
    login: Mock<AccessToken>? = nil,
    removeShopFromFavorite: Mock<UserFavoriteShop>? = nil,
=======
    deleteBirthday: Mock<Birthday>? = nil,
    login: Mock<AccessToken>? = nil,
    removeShopFromFavorite: Mock<UserFavoriteShop>? = nil,
    signUp: Mock<User>? = nil,
>>>>>>> fbcba15 (Added new functionality, fixed bugs, added UI elements)
    updateProfile: Mock<User>? = nil
  ) {
    self.init()
    self.addShopToFavorite = addShopToFavorite
<<<<<<< HEAD
    self.changePassword = changePassword
    self.deleteBirthday = deleteBirthday
    self.login = login
    self.removeShopFromFavorite = removeShopFromFavorite
=======
    self.deleteBirthday = deleteBirthday
    self.login = login
    self.removeShopFromFavorite = removeShopFromFavorite
    self.signUp = signUp
>>>>>>> fbcba15 (Added new functionality, fixed bugs, added UI elements)
    self.updateProfile = updateProfile
  }
}
