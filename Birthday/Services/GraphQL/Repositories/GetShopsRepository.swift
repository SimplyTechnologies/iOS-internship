
import Combine

protocol ShopsRepository: GraphQLRepository {
  
  func getShops(shopFilter: Api.ShopFilter) -> AnyPublisher<[Api.GetShopsQuery.Data.Shop], Error>
  
}

final class ShopsRepositoryImpl: ShopsRepository {
  
  func getShops(shopFilter: Api.ShopFilter) -> AnyPublisher<[Api.GetShopsQuery.Data.Shop], Error> {
    return request(query: Api.GetShopsQuery(filter: shopFilter))
      .compactMap { $0.shops }
      .eraseToAnyPublisher()
  }
  
}
