// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class ResetPasswordEmailMutation: GraphQLMutation {
    public static let operationName: String = "ResetPasswordEmail"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation ResetPasswordEmail($email: String!) {
          resetPasswordEmail(email: $email) {
            __typename
            id
            hash
            email
            password
          }
        }
        """#
      ))

    public var email: String

    public init(email: String) {
      self.email = email
    }

    public var __variables: Variables? { ["email": email] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Mutation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("resetPasswordEmail", ResetPasswordEmail?.self, arguments: ["email": .variable("email")]),
      ] }

      public var resetPasswordEmail: ResetPasswordEmail? { __data["resetPasswordEmail"] }

      /// ResetPasswordEmail
      ///
      /// Parent Type: `User`
      public struct ResetPasswordEmail: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Api.ID.self),
          .field("hash", String?.self),
          .field("email", String.self),
          .field("password", String?.self),
        ] }

        public var id: Api.ID { __data["id"] }
        public var hash: String? { __data["hash"] }
        public var email: String { __data["email"] }
        public var password: String? { __data["password"] }
      }
    }
  }

}