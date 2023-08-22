// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Query: MockObject {
  public static let objectType: Object = Api.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<[User]>("users") public var users
  }
}

public extension Mock where O == Query {
  convenience init(
    users: [Mock<User>]? = nil
  ) {
    self.init()
    self.users = users
  }
}
