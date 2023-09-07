
import Foundation

struct AddBirthdayModel {
  
  var name: String
  var image: String
  var message: String
  var date: Date
  var relation: String
  
  init(
    name: String,
    image: String,
    message: String,
    date: Date,
    relation: String
  ) {
    self.name = name
    self.image = image
    self.message = message
    self.date = date
    self.relation = relation
  }
  
  init(dto: Api.GetBirthdaysQuery.Data.Birthday) {
    name = dto.name
    image = dto.image ?? ""
    message = dto.message ?? ""
    date = dto.date?.dateFromString() ?? Date()
    relation = dto.relation
  }
}
