// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Birthday: MockObject {
  public static let objectType: Object = Api.Objects.Birthday
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Birthday>>

  public struct MockFields {
    @Field<Api.Date>("createdAt") public var createdAt
    @Field<Api.Date>("date") public var date
    @Field<Int>("id") public var id
    @Field<String>("image") public var image
    @Field<String>("message") public var message
    @Field<String>("name") public var name
    @Field<String>("relation") public var relation
    @Field<Int>("upcomingAge") public var upcomingAge
    @Field<Api.Date>("upcomingBirthday") public var upcomingBirthday
    @Field<Api.Date>("updatedAt") public var updatedAt
    @Field<Int>("userId") public var userId
  }
}

public extension Mock where O == Birthday {
  convenience init(
    createdAt: Api.Date? = nil,
    date: Api.Date? = nil,
    id: Int? = nil,
    image: String? = nil,
    message: String? = nil,
    name: String? = nil,
    relation: String? = nil,
    upcomingAge: Int? = nil,
    upcomingBirthday: Api.Date? = nil,
    updatedAt: Api.Date? = nil,
    userId: Int? = nil
  ) {
    self.init()
    self.createdAt = createdAt
    self.date = date
    self.id = id
    self.image = image
    self.message = message
    self.name = name
    self.relation = relation
    self.upcomingAge = upcomingAge
    self.upcomingBirthday = upcomingBirthday
    self.updatedAt = updatedAt
    self.userId = userId
  }
}
