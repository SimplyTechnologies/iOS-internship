
import Combine

protocol AddRemoveShopToFavoriteRepository: GraphQLRepository {
  
  func addShopToFavorite(shopId: Int) -> AnyPublisher<Api.AddShopToFavoriteMutation.Data.AddShopToFavorite, Error>
  func removeShopFromFavorite(shopId: Int) -> AnyPublisher<Api.RemoveShopFromFavoriteMutation.Data.RemoveShopFromFavorite, Error>
}

final class AddRemoveShopToFavoriteImpl: AddRemoveShopToFavoriteRepository {
  
  func addShopToFavorite(shopId: Int) -> AnyPublisher<Api.AddShopToFavoriteMutation.Data.AddShopToFavorite, Error> {
    return request(mutation: Api.AddShopToFavoriteMutation(shopId: shopId))
      .compactMap { $0.addShopToFavorite }
      .eraseToAnyPublisher()
  }
  
  func removeShopFromFavorite(shopId: Int) -> AnyPublisher<Api.RemoveShopFromFavoriteMutation.Data.RemoveShopFromFavorite, Error> {
    return request(mutation: Api.RemoveShopFromFavoriteMutation(shopId: shopId))
      .compactMap { $0.removeShopFromFavorite }
      .eraseToAnyPublisher()
  }
  
}
