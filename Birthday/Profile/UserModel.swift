
struct User {
  
  var firstName: String
  var lastName: String
  var email: String
  var image: String
  
}
struct UserModel{
  
  private(set) var users : [User] = []
  
}
