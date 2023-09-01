// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class UserFavoriteShop: MockObject {
  public static let objectType: Object = Api.Objects.UserFavoriteShop
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<UserFavoriteShop>>

  public struct MockFields {
    @Field<Api.Date>("createdAt") public var createdAt
    @Field<Int>("id") public var id
    @Field<Int>("shopId") public var shopId
    @Field<Int>("userId") public var userId
  }
}

public extension Mock where O == UserFavoriteShop {
  convenience init(
    createdAt: Api.Date? = nil,
    id: Int? = nil,
    shopId: Int? = nil,
    userId: Int? = nil
  ) {
    self.init()
    self.createdAt = createdAt
    self.id = id
    self.shopId = shopId
    self.userId = userId
  }
}
