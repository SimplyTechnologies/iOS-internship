// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class SignUpMutation: GraphQLMutation {
    public static let operationName: String = "signUp"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation signUp($signUpInput: SignUpInput!) {
          signUp(signUpInput: $signUpInput) {
            __typename
            id
            email
            firstName
            lastName
          }
        }
        """#
      ))

    public var signUpInput: SignUpInput

    public init(signUpInput: SignUpInput) {
      self.signUpInput = signUpInput
    }

    public var __variables: Variables? { ["signUpInput": signUpInput] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Mutation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("signUp", SignUp?.self, arguments: ["signUpInput": .variable("signUpInput")]),
      ] }

      public var signUp: SignUp? { __data["signUp"] }

      /// SignUp
      ///
      /// Parent Type: `User`
      public struct SignUp: Api.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Api.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Api.ID.self),
          .field("email", String.self),
          .field("firstName", String.self),
          .field("lastName", String.self),
        ] }

        public var id: Api.ID { __data["id"] }
        public var email: String { __data["email"] }
        public var firstName: String { __data["firstName"] }
        public var lastName: String { __data["lastName"] }
      }
    }
  }

}