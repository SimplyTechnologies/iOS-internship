
class Shop: Equatable {
  static func == (lhs: Shop, rhs: Shop) -> Bool {
    lhs.id == rhs.id
  }
  
  let id: Int
  let name: String
  let image: String
  let phone: String
  let address: String
  let url: String
  let rate: Float
  var isFavorite: Bool
  
  init(id: Int, name: String, image: String, phone: String, address: String, url: String, rate: Float, isFavorite: Bool) {
    self.id = id
    self.name = name
    self.image = image
    self.phone = phone
    self.address = address
    self.url = url
    self.rate = rate
    self.isFavorite = isFavorite
  }
}

