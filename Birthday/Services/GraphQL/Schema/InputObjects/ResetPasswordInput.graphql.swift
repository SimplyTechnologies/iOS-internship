// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Api {
  struct ResetPasswordInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      hash: String,
      password: String,
      email: String
    ) {
      __data = InputDict([
        "hash": hash,
        "password": password,
        "email": email
      ])
    }

    public var hash: String {
      get { __data["hash"] }
      set { __data["hash"] = newValue }
    }

    public var password: String {
      get { __data["password"] }
      set { __data["password"] = newValue }
    }

    public var email: String {
      get { __data["email"] }
      set { __data["email"] = newValue }
    }
  }

}