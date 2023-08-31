
class Shop: Equatable {
  
  let id: Int
  let name: String
  let image: String
  let phone: String
  let address: String
  let url: String
  let rate: Float
  var isFavorite: Bool
  
  init(
    id: Int,
    name: String,
    image: String,
    phone: String,
    address: String,
    url: String,
    rate: Float,
    isFavorite: Bool
  ) {
    self.id = id
    self.name = name
    self.image = image
    self.phone = phone
    self.address = address
    self.url = url
    self.rate = rate
    self.isFavorite = isFavorite
  }
  
  init(dto: Api.GetShopsQuery.Data.Shop) {
    id = dto.id
    name = dto.name
    image = dto.image
    phone = dto.phone ?? ""
    address = dto.address
    url = dto.url ?? ""
    rate = Float(dto.rate ?? 0.0)
    isFavorite = dto.isFavorite ?? false
  }
  
  static func == (lhs: Shop, rhs: Shop) -> Bool {
    lhs.id == rhs.id
    
  }
  
}
