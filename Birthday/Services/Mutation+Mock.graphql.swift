// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Mutation: MockObject {
  public static let objectType: Object = Api.Objects.Mutation
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Mutation>>

  public struct MockFields {
    @Field<AccessToken>("login") public var login
  }
}

public extension Mock where O == Mutation {
  convenience init(
    login: Mock<AccessToken>? = nil
  ) {
    self.init()
    self.login = login
  }
}
