
import Combine
import Foundation

class ShopListViewModel: ObservableObject {
  
  @Published var searchText = ""
  @Published private var shops: [Shop] = []
  @Published var toasts: [Toast] = []
  @Published var isLoading = true
    
  private var cancellables: Set<AnyCancellable> = []
  private let shopsRepository: ShopsRepository = ShopsRepositoryImpl()
  private let favoriteShopsRepository = AddRemoveShopToFavoriteImpl()
  
  var sortedShops: [Shop] {
    filteredShops.sorted {
      $0.isFavorite && !$1.isFavorite
    }
  }
  
  private var filteredShops: [Shop] {
    shops.filter {
      searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
    }
  }
  
  func getShops(shopFilter: Api.ShopFilter) {
    isLoading = true
    shopsRepository.getShops(shopFilter: shopFilter)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] response in
        self?.isLoading = false
        switch response {
        case .finished: break
        case .failure: break
        }
      } receiveValue: { [weak self] shopData in
        let shopsModels = shopData.map { Shop(dto: $0) }
        self?.shops = shopsModels
      }
      .store(in: &cancellables)
  }

  func onTapFavoriteIcon(_ shop: Shop) {
    if !shop.isFavorite {
      addShopToFavorite(shop)
    } else {
      removeShopFromFavorite(shop)
    }
  }
  
  private func showToast(shop: Shop) {
    let message = shop.isFavorite ? "\(shop.name) is added to Favorites ♥️" : "\(shop.name) is removed from Favorites 💔"
    let toast = Toast(
      message: message,
      isSuccess: true
    )
    toasts.append(toast)
    DispatchQueue.main.asyncAfter(
      deadline: .now() + toast.duration
    ) {
      if let index = self.toasts.firstIndex(
        where: { $0 == toast }) {
        self.toasts.remove(at: index)
      }
    }
  }
  
  private func addShopToFavorite(_ shop: Shop) {
    favoriteShopsRepository.addShopToFavorite(shopId: shop.id)
      .receive(on: DispatchQueue.main)
      .sink { response in
        switch response {
        case .finished: break
        case .failure: break
        }
      } receiveValue: { [weak self] response in
        self?.shops.first(where: {$0.id == response.shopId})?.isFavorite.toggle()
        self?.showToast(shop: shop)
      }
      .store(in: &cancellables)
  }
  
  private func removeShopFromFavorite(_ shop: Shop) {
    favoriteShopsRepository.removeShopFromFavorite(shopId: shop.id)
      .receive(on: DispatchQueue.main)
      .sink { response in
        switch response {
        case .finished: break
        case .failure: break
        }
      } receiveValue: { [weak self] response in
        self?.shops.first(where: {$0.id == response.shopId})?.isFavorite.toggle()
        self?.showToast(shop: shop)
      }
      .store(in: &cancellables)
  }
  
}
