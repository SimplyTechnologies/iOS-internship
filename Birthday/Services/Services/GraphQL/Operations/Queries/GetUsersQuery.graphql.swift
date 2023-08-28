// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class GetUsersQuery: GraphQLQuery {
    public static let operationName: String = "GetUsers"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetUsers {
          users {
            __typename
            id
            lastName
            email
            firstName
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
        .field("users", [User].self),
      ] }

      public var users: [User] { __data["users"] }

      /// User
      ///
      /// Parent Type: `User`
      public struct User: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Api.ID.self),
          .field("lastName", String.self),
          .field("email", String.self),
          .field("firstName", String.self),
        ] }

        public var id: Api.ID { __data["id"] }
        public var lastName: String { __data["lastName"] }
        public var email: String { __data["email"] }
        public var firstName: String { __data["firstName"] }
      }
    }
  }

}