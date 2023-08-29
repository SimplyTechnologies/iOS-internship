// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class GetBirthdaysQuery: GraphQLQuery {
    public static let operationName: String = "GetBirthdays"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetBirthdays {
          birthdays {
            __typename
            id
            userId
            name
            image
            relation
            message
            date
            upcomingBirthday
            upcomingAge
            createdAt
            updatedAt
          }
        }
        """#
      ))

    public init() {}

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("birthdays", [Birthday].self),
      ] }

      public var birthdays: [Birthday] { __data["birthdays"] }

      /// Birthday
      ///
      /// Parent Type: `Birthday`
      public struct Birthday: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.Birthday }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("userId", Int.self),
          .field("name", String.self),
          .field("image", String?.self),
          .field("relation", String.self),
          .field("message", String?.self),
          .field("date", Api.Date?.self),
          .field("upcomingBirthday", Api.Date?.self),
          .field("upcomingAge", Int?.self),
          .field("createdAt", Api.Date?.self),
          .field("updatedAt", Api.Date?.self),
        ] }

        public var id: Int { __data["id"] }
        public var userId: Int { __data["userId"] }
        public var name: String { __data["name"] }
        public var image: String? { __data["image"] }
        public var relation: String { __data["relation"] }
        public var message: String? { __data["message"] }
        public var date: Api.Date? { __data["date"] }
        public var upcomingBirthday: Api.Date? { __data["upcomingBirthday"] }
        public var upcomingAge: Int? { __data["upcomingAge"] }
        public var createdAt: Api.Date? { __data["createdAt"] }
        public var updatedAt: Api.Date? { __data["updatedAt"] }
      }
    }
  }
}
