// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class ChangePasswordMutation: GraphQLMutation {
    public static let operationName: String = "ChangePassword"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation ChangePassword($oldPassword: String!, $newPassword: String!) {
          changePassword(oldPassword: $oldPassword, newPassword: $newPassword) {
            __typename
            id
          }
        }
        """#
      ))

    public var oldPassword: String
    public var newPassword: String

    public init(
      oldPassword: String,
      newPassword: String
    ) {
      self.oldPassword = oldPassword
      self.newPassword = newPassword
    }

    public var __variables: Variables? { [
      "oldPassword": oldPassword,
      "newPassword": newPassword
    ] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Mutation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("changePassword", ChangePassword?.self, arguments: [
          "oldPassword": .variable("oldPassword"),
          "newPassword": .variable("newPassword")
        ]),
      ] }

      public var changePassword: ChangePassword? { __data["changePassword"] }

      /// ChangePassword
      ///
      /// Parent Type: `User`
      public struct ChangePassword: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Api.ID.self),
        ] }

        public var id: Api.ID { __data["id"] }
      }
    }
  }

}