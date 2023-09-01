// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension Api {
  class UpdateProfileMutation: GraphQLMutation {
    public static let operationName: String = "UpdateProfile"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation UpdateProfile($updateProfileInput: UpdateProfileInput!) {
          updateProfile(updateProfileInput: $updateProfileInput) {
            __typename
            id
            email
            firstName
            lastName
            image
          }
        }
        """#
      ))

    public var updateProfileInput: UpdateProfileInput

    public init(updateProfileInput: UpdateProfileInput) {
      self.updateProfileInput = updateProfileInput
    }

    public var __variables: Variables? { ["updateProfileInput": updateProfileInput] }

    public struct Data: Api.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Api.Objects.Mutation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("updateProfile", UpdateProfile?.self, arguments: ["updateProfileInput": .variable("updateProfileInput")]),
      ] }

      public var updateProfile: UpdateProfile? { __data["updateProfile"] }

      /// UpdateProfile
      ///
      /// Parent Type: `User`
      public struct UpdateProfile: Api.SelectionSet {
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
        ] }

        public var id: Api.ID { __data["id"] }
        public var email: String { __data["email"] }
        public var firstName: String { __data["firstName"] }
        public var lastName: String { __data["lastName"] }
        public var image: String? { __data["image"] }
      }
    }
  }

}