// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Query: MockObject {
  public static let objectType: Object = Api.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<[Birthday]>("birthdays") public var birthdays
<<<<<<< HEAD
    @Field<[Shop]>("shops") public var shops
=======
    @Field<User>("profile") public var profile
>>>>>>> 535f33c (delete birthday)
    @Field<[User]>("users") public var users
  }
}

public extension Mock where O == Query {
  convenience init(
    birthdays: [Mock<Birthday>]? = nil,
<<<<<<< HEAD
    shops: [Mock<Shop>]? = nil,
=======
    profile: Mock<User>? = nil,
>>>>>>> 535f33c (delete birthday)
    users: [Mock<User>]? = nil
  ) {
    self.init()
    self.birthdays = birthdays
<<<<<<< HEAD
    self.shops = shops
=======
    self.profile = profile
>>>>>>> 535f33c (delete birthday)
    self.users = users
  }
}
