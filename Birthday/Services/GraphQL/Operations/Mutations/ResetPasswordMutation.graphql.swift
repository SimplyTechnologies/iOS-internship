// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class ResetPasswordMutation: GraphQLMutation {
    public static let operationName: String = "ResetPassword"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation ResetPassword($resetPasswordInput: ResetPasswordInput!) {
          resetPassword(resetPasswordInput: $resetPasswordInput) {
            __typename
            id
            password
          }
        }
        """#
      ))

    public var resetPasswordInput: ResetPasswordInput

    public init(resetPasswordInput: ResetPasswordInput) {
      self.resetPasswordInput = resetPasswordInput
    }

    public var __variables: Variables? { ["resetPasswordInput": resetPasswordInput] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Mutation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("resetPassword", ResetPassword?.self, arguments: ["resetPasswordInput": .variable("resetPasswordInput")]),
      ] }

      public var resetPassword: ResetPassword? { __data["resetPassword"] }

      /// ResetPassword
      ///
      /// Parent Type: `User`
      public struct ResetPassword: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Api.ID.self),
          .field("password", String?.self),
        ] }

        public var id: Api.ID { __data["id"] }
        public var password: String? { __data["password"] }
      }
    }
  }

}