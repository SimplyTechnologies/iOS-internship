// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class GetProfileQuery: GraphQLQuery {
    public static let operationName: String = "GetProfile"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetProfile {
          profile {
            __typename
            id
            email
            firstName
            lastName
            image
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
        .field("profile", Profile?.self),
      ] }

      public var profile: Profile? { __data["profile"] }

      /// Profile
      ///
      /// Parent Type: `User`
      public struct Profile: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Api.ID.self),
          .field("email", String.self),
          .field("firstName", String.self),
          .field("lastName", String.self),
          .field("image", String?.self),
          .field("createdAt", Api.Date?.self),
          .field("updatedAt", Api.Date?.self),
        ] }

        public var id: Api.ID { __data["id"] }
        public var email: String { __data["email"] }
        public var firstName: String { __data["firstName"] }
        public var lastName: String { __data["lastName"] }
        public var image: String? { __data["image"] }
        public var createdAt: Api.Date? { __data["createdAt"] }
        public var updatedAt: Api.Date? { __data["updatedAt"] }
      }
    }
  }

}