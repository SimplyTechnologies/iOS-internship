
struct Toast: Equatable, Hashable {
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(message)
  }
  
  var message: String
  var duration: Double = 3
  var isSuccess: Bool
  
}
