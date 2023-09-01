// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Api {
  struct UpdateProfileInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      firstName: GraphQLNullable<String> = nil,
      lastName: GraphQLNullable<String> = nil,
      image: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "firstName": firstName,
        "lastName": lastName,
        "image": image
      ])
    }

    public var firstName: GraphQLNullable<String> {
      get { __data["firstName"] }
      set { __data["firstName"] = newValue }
    }

    public var lastName: GraphQLNullable<String> {
      get { __data["lastName"] }
      set { __data["lastName"] = newValue }
    }

    public var image: GraphQLNullable<String> {
      get { __data["image"] }
      set { __data["image"] = newValue }
    }
  }

}