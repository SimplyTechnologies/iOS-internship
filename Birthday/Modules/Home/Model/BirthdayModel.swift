
import Foundation

struct BirthdayModel: Hashable {
  
  let id: Int
  let userId: Int
  let name: String
  let image: String
  let relation: String
  let message: String
  let date: Date
  let upcomingBirthday: Date
  let upcomingAge: Int
  let createdAt: Date
  let updatedAt: Date
  
  init(
    id: Int,
    userId: Int,
    name: String,
    image: String,
    relation: String,
    message: String,
    date: Date,
    upcomingBirthday: Date,
    upcomingAge: Int,
    createdAt: Date,
    updatedAt: Date
  ) {
    self.id = id
    self.userId = userId
    self.name = name
    self.image = image
    self.relation = relation
    self.message = message
    self.date = date
    self.upcomingBirthday = upcomingBirthday
    self.upcomingAge = upcomingAge
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }
  
  init(dto: Api.GetBirthdaysQuery.Data.Birthday) {
    id = dto.id
    userId = dto.userId
    name = dto.name
    image = dto.image ?? ""
    relation = dto.relation
    message = dto.message ?? ""
    date = dto.date?.dateFromString() ?? Date()
    upcomingBirthday = dto.upcomingBirthday?.dateFromString() ?? Date()
    upcomingAge = dto.upcomingAge ?? 0
    createdAt = dto.createdAt?.dateFromString() ?? Date()
    updatedAt = dto.updatedAt?.dateFromString() ?? Date()
  }
  
}
