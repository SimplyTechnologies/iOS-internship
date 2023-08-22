// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class User: MockObject {
  public static let objectType: Object = Api.Objects.User
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<User>>

  public struct MockFields {
    @Field<String>("email") public var email
    @Field<String>("firstName") public var firstName
    @Field<Api.ID>("id") public var id
    @Field<String>("lastName") public var lastName
  }
}

public extension Mock where O == User {
  convenience init(
    email: String? = nil,
    firstName: String? = nil,
    id: Api.ID? = nil,
    lastName: String? = nil
  ) {
    self.init()
    self.email = email
    self.firstName = firstName
    self.id = id
    self.lastName = lastName
  }
}
