// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class LoginMutation: GraphQLMutation {
    public static let operationName: String = "login"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation login($loginInput: LoginInput!) {
          login(loginInput: $loginInput) {
            __typename
            access_token
          }
        }
        """#
      ))

    public var loginInput: LoginInput

    public init(loginInput: LoginInput) {
      self.loginInput = loginInput
    }

    public var __variables: Variables? { ["loginInput": loginInput] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Mutation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("login", Login?.self, arguments: ["loginInput": .variable("loginInput")]),
      ] }

      public var login: Login? { __data["login"] }

      /// Login
      ///
      /// Parent Type: `AccessToken`
      public struct Login: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.AccessToken }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("access_token", String.self),
        ] }

        public var access_token: String { __data["access_token"] }
      }
    }
  }

}