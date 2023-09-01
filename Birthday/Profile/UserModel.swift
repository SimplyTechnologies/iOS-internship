
struct UserModel {
  
  let id: String
  var email: String
  var firstName: String
  var lastName: String
  var image: String
  
  init(
    id: String = "1",
    email: String = "example@gmail.com",
    firstName: String = "John",
    lastName: String = "Doe",
    image: String = ""
  ) {
    self.id = id
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
    self.image = image
  }
  
  init(dto: Api.GetProfileQuery.Data.Profile) {
    id = dto.id
    email = dto.email
    firstName = dto.firstName
    lastName = dto.lastName
    image = dto.image ?? ""
  }
  
}
