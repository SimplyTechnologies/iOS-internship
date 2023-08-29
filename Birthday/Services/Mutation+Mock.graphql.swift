// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Mutation: MockObject {
  public static let objectType: Object = Api.Objects.Mutation
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Mutation>>

  public struct MockFields {
    @Field<Birthday>("deleteBirthday") public var deleteBirthday
  }
}

public extension Mock where O == Mutation {
  convenience init(
    deleteBirthday: Mock<Birthday>? = nil
  ) {
    self.init()
    self.deleteBirthday = deleteBirthday
  }
}
