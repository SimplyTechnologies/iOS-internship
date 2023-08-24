
import Combine

class ShopDetailViewModel: ObservableObject {
  
  var shop: Shop
  @Published var toasts: [Toast] = []
  private var onTapFavoriteIcon: (Shop) -> Void
  
  var addressURLString: String {
    "https://www.google.com/maps/search/?q=\(shop.address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }
  
  var websiteURL: String {
    "[Web Site](\(shop.url))"
  }
  
  var phone: String {
    "tel:\(shop.phone)"
  }
  
  init(
    shop: Shop,
    toasts: [Toast],
    onTapFavoriteIcon: @escaping (Shop) -> Void
  ) {
    self.shop = shop
    self.toasts = toasts
    self.onTapFavoriteIcon = onTapFavoriteIcon
  }
  
  func onTapFavoriteIcon(shop: Shop) {
    self.onTapFavoriteIcon(shop)
  }
  
}
