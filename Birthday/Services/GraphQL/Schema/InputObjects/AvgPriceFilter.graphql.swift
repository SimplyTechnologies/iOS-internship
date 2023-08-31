// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Api {
  struct AvgPriceFilter: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      lte: GraphQLNullable<Int> = nil,
      gte: GraphQLNullable<Int> = nil
    ) {
      __data = InputDict([
        "lte": lte,
        "gte": gte
      ])
    }

    public var lte: GraphQLNullable<Int> {
      get { __data["lte"] }
      set { __data["lte"] = newValue }
    }

    public var gte: GraphQLNullable<Int> {
      get { __data["gte"] }
      set { __data["gte"] = newValue }
    }
  }

}