// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Birthday

public class Shop: MockObject {
  public static let objectType: Object = Api.Objects.Shop
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Shop>>

  public struct MockFields {
    @Field<String>("address") public var address
    @Field<Int>("avgPrice") public var avgPrice
    @Field<Int>("id") public var id
    @Field<String>("image") public var image
    @Field<Bool>("isFavorite") public var isFavorite
    @Field<String>("name") public var name
    @Field<String>("phone") public var phone
    @Field<Double>("rate") public var rate
    @Field<String>("url") public var url
  }
}

public extension Mock where O == Shop {
  convenience init(
    address: String? = nil,
    avgPrice: Int? = nil,
    id: Int? = nil,
    image: String? = nil,
    isFavorite: Bool? = nil,
    name: String? = nil,
    phone: String? = nil,
    rate: Double? = nil,
    url: String? = nil
  ) {
    self.init()
    self.address = address
    self.avgPrice = avgPrice
    self.id = id
    self.image = image
    self.isFavorite = isFavorite
    self.name = name
    self.phone = phone
    self.rate = rate
    self.url = url
  }
}
