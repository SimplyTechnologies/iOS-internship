// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class GetShopsQuery: GraphQLQuery {
    public static let operationName: String = "GetShops"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetShops($filter: ShopFilter!) {
          shops(filter: $filter) {
            __typename
            id
            name
            image
            phone
            address
            url
            rate
            avgPrice
            isFavorite
          }
        }
        """#
      ))

    public var filter: ShopFilter

    public init(filter: ShopFilter) {
      self.filter = filter
    }

    public var __variables: Variables? { ["filter": filter] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("shops", [Shop].self, arguments: ["filter": .variable("filter")]),
      ] }

      public var shops: [Shop] { __data["shops"] }

      /// Shop
      ///
      /// Parent Type: `Shop`
      public struct Shop: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.Shop }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("name", String.self),
          .field("image", String.self),
          .field("phone", String?.self),
          .field("address", String.self),
          .field("url", String?.self),
          .field("rate", Double?.self),
          .field("avgPrice", Int?.self),
          .field("isFavorite", Bool?.self),
        ] }

        public var id: Int { __data["id"] }
        public var name: String { __data["name"] }
        public var image: String { __data["image"] }
        public var phone: String? { __data["phone"] }
        public var address: String { __data["address"] }
        public var url: String? { __data["url"] }
        public var rate: Double? { __data["rate"] }
        public var avgPrice: Int? { __data["avgPrice"] }
        public var isFavorite: Bool? { __data["isFavorite"] }
      }
    }
  }

}