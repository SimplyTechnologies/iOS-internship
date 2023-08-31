
struct UserModel {
  
  var firstName: String
  var lastName: String
  var email: String
  var image: String
  
  init(
    firstName: String,
    lastName: String,
    email: String,
    image: String
  ) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.image = image
  }
  
  init(dto: Api.GetProfileQuery.Data.Profile) {
    firstName = dto.firstName
    lastName = dto.lastName
    email = dto.email
    image = dto.image ?? ""
  }
  
}
