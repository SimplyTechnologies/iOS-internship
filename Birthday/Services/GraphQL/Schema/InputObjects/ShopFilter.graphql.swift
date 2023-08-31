// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Api {
  struct ShopFilter: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      rate: GraphQLNullable<RateFilter> = nil,
      avgPrice: GraphQLNullable<AvgPriceFilter> = nil
    ) {
      __data = InputDict([
        "rate": rate,
        "avgPrice": avgPrice
      ])
    }

    public var rate: GraphQLNullable<RateFilter> {
      get { __data["rate"] }
      set { __data["rate"] = newValue }
    }

    public var avgPrice: GraphQLNullable<AvgPriceFilter> {
      get { __data["avgPrice"] }
      set { __data["avgPrice"] = newValue }
    }
  }

}