// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Api {
  struct CreateBirthdayInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      name: String,
      image: GraphQLNullable<String> = nil,
      relation: String,
      message: GraphQLNullable<String> = nil,
      date: Date
    ) {
      __data = InputDict([
        "name": name,
        "image": image,
        "relation": relation,
        "message": message,
        "date": date
      ])
    }

    public var name: String {
      get { __data["name"] }
      set { __data["name"] = newValue }
    }

    public var image: GraphQLNullable<String> {
      get { __data["image"] }
      set { __data["image"] = newValue }
    }

    public var relation: String {
      get { __data["relation"] }
      set { __data["relation"] = newValue }
    }

    public var message: GraphQLNullable<String> {
      get { __data["message"] }
      set { __data["message"] = newValue }
    }

    public var date: Date {
      get { __data["date"] }
      set { __data["date"] = newValue }
    }
  }

}