
struct Toast: Equatable, Hashable {
  
  var message: String
  var duration: Double = 3
  var isSuccess: Bool
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(message)
  }
  
}
