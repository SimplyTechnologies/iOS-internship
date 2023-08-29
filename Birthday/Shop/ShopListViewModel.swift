
import Combine
import Foundation

class ShopListViewModel: ObservableObject {
  
  @Published var searchText = ""
  @Published private var shops: [Shop] = []
  @Published var toasts: [Toast] = []
  @Published var isLoading = true
  
  private var cancellables: Set<AnyCancellable> = []
  private let shopsRepository: ShopsRepository = ShopsRepositoryImpl()
  
  func getShops(shopFilter: Api.ShopFilter) {
    isLoading = true
    shopsRepository.getShops(shopFilter: shopFilter)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] shopData in
        let shopsModels = shopData.map { Shop(dto: $0) }
        self?.shops = shopsModels
      }
      .store(in: &cancellables)
  }
  
  init() {
    getShops(shopFilter: Api.ShopFilter())
  }
  
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
  
  func onTapFavoriteIcon(shop: Shop) {
    shop.isFavorite.toggle()
    self.objectWillChange.send()
    showToast(shop: shop)
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
  
}
