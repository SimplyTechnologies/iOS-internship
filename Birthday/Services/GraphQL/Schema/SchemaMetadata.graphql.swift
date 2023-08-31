// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol Api_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == Api.SchemaMetadata {}

public protocol Api_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == Api.SchemaMetadata {}

public protocol Api_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == Api.SchemaMetadata {}

public protocol Api_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == Api.SchemaMetadata {}

public extension Api {
  typealias ID = String

  typealias SelectionSet = Api_SelectionSet

  typealias InlineFragment = Api_InlineFragment

  typealias MutableSelectionSet = Api_MutableSelectionSet

  typealias MutableInlineFragment = Api_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return Api.Objects.Query
      case "User": return Api.Objects.User
      case "Birthday": return Api.Objects.Birthday
      case "Mutation": return Api.Objects.Mutation
      case "Shop": return Api.Objects.Shop
      case "UserFavoriteShop": return Api.Objects.UserFavoriteShop
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}