// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class AccessToken: MockObject {
  public static let objectType: Object = Api.Objects.AccessToken
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<AccessToken>>

  public struct MockFields {
    @Field<String>("access_token") public var access_token
  }
}

public extension Mock where O == AccessToken {
  convenience init(
    access_token: String? = nil
  ) {
    self.init()
    self.access_token = access_token
  }
}
