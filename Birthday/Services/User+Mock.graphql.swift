// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class User: MockObject {
  public static let objectType: Object = Api.Objects.User
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<User>>

  public struct MockFields {
    @Field<Api.Date>("createdAt") public var createdAt
    @Field<String>("email") public var email
    @Field<String>("firstName") public var firstName
    @Field<Api.ID>("id") public var id
    @Field<String>("image") public var image
    @Field<String>("lastName") public var lastName
    @Field<Api.Date>("updatedAt") public var updatedAt
  }
}

public extension Mock where O == User {
  convenience init(
    createdAt: Api.Date? = nil,
    email: String? = nil,
    firstName: String? = nil,
    id: Api.ID? = nil,
    image: String? = nil,
    lastName: String? = nil,
    updatedAt: Api.Date? = nil
  ) {
    self.init()
    self.createdAt = createdAt
    self.email = email
    self.firstName = firstName
    self.id = id
    self.image = image
    self.lastName = lastName
    self.updatedAt = updatedAt
  }
}
