
import Combine
import Foundation

class ShopListViewModel: ObservableObject {
  @Published var searchText = ""
  
  @Published private var shops: [Shop] = [
    Shop(id: 111, name: "McDonald's", image: "photo.on.rectangle", phone: "0938427523", address: "Merab Kostava St, Tbilisi, Georgia", url: "https://www.mcdonalds.com/us/en-us.html", rate: 3.9, isFavorite: false),
    Shop(id: 112, name: "H&M", image: "photo.on.rectangle", phone: "0938427523", address: "isjbv", url: "https://www2.hm.com/en_us/index.html", rate: 3.9, isFavorite: false),
    Shop(id: 113, name: "Hugo Boss", image: "photo.on.rectangle", phone: "0938427523", address: "isjbv", url: "https://www.hugoboss.com/selectcountry", rate: 3.9, isFavorite: true),
    Shop(id: 114, name: "KFC", image: "photo.on.rectangle", phone: "0938427523", address: "isjbv", url: "https://global.kfc.com/", rate: 3.9, isFavorite: false),
    Shop(id: 115, name: "Burger King", image: "photo.on.rectangle", phone: "0938427523", address: "isjbv", url: "https://www.bk.com/", rate: 3.9, isFavorite: true),
    Shop(id: 116, name: "Zara", image: "photo.on.rectangle", phone: "0938427523", address: "11 George Balanchini St", url: "https://www.zara.com/", rate: 3.9, isFavorite: true)
  ]
  
  @Published var toasts: [Toast] = []
  
  var sortedShops: [Shop] {
    filteredShops.sorted { $0.isFavorite && !$1.isFavorite }
  }
  
  private var filteredShops: [Shop] {
    shops.filter {searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
  }
  
  func onTapFavoriteIcon(shop: Shop) {
    shop.isFavorite.toggle()
    self.objectWillChange.send()
    showToast(shop: shop)
  }
  
  private func showToast(shop: Shop) {
    let message = shop.isFavorite ? "\(shop.name) is added to Favorites ♥️" : "\(shop.name) is removed from Favorites 💔"
    let toast = Toast(message: message, isSuccess: true)
    toasts.append(toast)
    DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
      if let index = self.toasts.firstIndex(where: { $0 == toast }) {
        self.toasts.remove(at: index)
      }
    }
  }
}
