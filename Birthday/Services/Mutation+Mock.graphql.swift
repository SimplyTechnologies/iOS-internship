// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Mutation: MockObject {
  public static let objectType: Object = Api.Objects.Mutation
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Mutation>>

  public struct MockFields {
<<<<<<< HEAD
    @Field<UserFavoriteShop>("addShopToFavorite") public var addShopToFavorite
    @Field<UserFavoriteShop>("removeShopFromFavorite") public var removeShopFromFavorite
=======
    @Field<Birthday>("deleteBirthday") public var deleteBirthday
>>>>>>> 535f33c (delete birthday)
  }
}

public extension Mock where O == Mutation {
  convenience init(
<<<<<<< HEAD
    addShopToFavorite: Mock<UserFavoriteShop>? = nil,
    removeShopFromFavorite: Mock<UserFavoriteShop>? = nil
  ) {
    self.init()
    self.addShopToFavorite = addShopToFavorite
    self.removeShopFromFavorite = removeShopFromFavorite
=======
    deleteBirthday: Mock<Birthday>? = nil
  ) {
    self.init()
    self.deleteBirthday = deleteBirthday
>>>>>>> 535f33c (delete birthday)
  }
}
