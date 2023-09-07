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
<<<<<<< HEAD
    @Field<Api.ID>("id") public var id
    @Field<String>("image") public var image
    @Field<String>("lastName") public var lastName
=======
    @Field<String>("hash") public var hash
    @Field<Api.ID>("id") public var id
    @Field<String>("image") public var image
    @Field<String>("lastName") public var lastName
    @Field<String>("password") public var password
>>>>>>> bd3e785 (Added forgot password and new password views with their mutations and custom text field styles)
    @Field<Api.Date>("updatedAt") public var updatedAt
  }
}

public extension Mock where O == User {
  convenience init(
    createdAt: Api.Date? = nil,
    email: String? = nil,
    firstName: String? = nil,
<<<<<<< HEAD
    id: Api.ID? = nil,
    image: String? = nil,
    lastName: String? = nil,
=======
    hash: String? = nil,
    id: Api.ID? = nil,
    image: String? = nil,
    lastName: String? = nil,
    password: String? = nil,
>>>>>>> bd3e785 (Added forgot password and new password views with their mutations and custom text field styles)
    updatedAt: Api.Date? = nil
  ) {
    self.init()
    self.createdAt = createdAt
    self.email = email
    self.firstName = firstName
<<<<<<< HEAD
    self.id = id
    self.image = image
    self.lastName = lastName
=======
    self.hash = hash
    self.id = id
    self.image = image
    self.lastName = lastName
    self.password = password
>>>>>>> bd3e785 (Added forgot password and new password views with their mutations and custom text field styles)
    self.updatedAt = updatedAt
  }
}
