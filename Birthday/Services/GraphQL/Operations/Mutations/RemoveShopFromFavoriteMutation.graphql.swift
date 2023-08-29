// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class RemoveShopFromFavoriteMutation: GraphQLMutation {
    public static let operationName: String = "removeShopFromFavorite"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation removeShopFromFavorite($shopId: Int!) {
          removeShopFromFavorite(shopId: $shopId) {
            __typename
            id
            userId
            shopId
            createdAt
          }
        }
        """#
      ))

    public var shopId: Int

    public init(shopId: Int) {
      self.shopId = shopId
    }

    public var __variables: Variables? { ["shopId": shopId] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Mutation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("removeShopFromFavorite", RemoveShopFromFavorite?.self, arguments: ["shopId": .variable("shopId")]),
      ] }

      public var removeShopFromFavorite: RemoveShopFromFavorite? { __data["removeShopFromFavorite"] }

      /// RemoveShopFromFavorite
      ///
      /// Parent Type: `UserFavoriteShop`
      public struct RemoveShopFromFavorite: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.UserFavoriteShop }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("userId", Int.self),
          .field("shopId", Int.self),
          .field("createdAt", Api.Date?.self),
        ] }

        public var id: Int { __data["id"] }
        public var userId: Int { __data["userId"] }
        public var shopId: Int { __data["shopId"] }
        public var createdAt: Api.Date? { __data["createdAt"] }
      }
    }
  }

}