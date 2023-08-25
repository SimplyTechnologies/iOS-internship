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
    @Field<[User]>("users") public var users
  }
}

public extension Mock where O == Query {
  convenience init(
    birthdays: [Mock<Birthday>]? = nil,
    users: [Mock<User>]? = nil
  ) {
    self.init()
    self.birthdays = birthdays
    self.users = users
  }
}
