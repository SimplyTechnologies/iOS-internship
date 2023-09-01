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
    @Field<Birthday>("deleteBirthday") public var deleteBirthday
    @Field<AccessToken>("login") public var login
    @Field<UserFavoriteShop>("removeShopFromFavorite") public var removeShopFromFavorite
  }
}

public extension Mock where O == Mutation {
  convenience init(
    addShopToFavorite: Mock<UserFavoriteShop>? = nil,
    deleteBirthday: Mock<Birthday>? = nil,
    login: Mock<AccessToken>? = nil,
    removeShopFromFavorite: Mock<UserFavoriteShop>? = nil
  ) {
    self.init()
    self.addShopToFavorite = addShopToFavorite
    self.deleteBirthday = deleteBirthday
    self.login = login
    self.removeShopFromFavorite = removeShopFromFavorite
  }
}
