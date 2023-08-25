
import SwiftUI

struct BirthdayCell: View {
  
  var model: BirthdayModel
  
  var body: some View {
    HStack {
      imageView
      VStack(alignment: .leading, spacing: 15) {
        Text(model.name)
        Text(model.date.stringFromDate())
      }
      Spacer()
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 16)
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(24)
  }
  
  private var imageView: some View {
    AsyncImage(url: URL(string: model.image)) { image in
      image
        .resizable()
        .frame(width: 70, height: 70)
        .scaledToFit()
        .cornerRadius(50)
    } placeholder: {
      Color.secondaryColor
        .cornerRadius(40)
    }
    .frame(width: 70, height: 70)
    .padding(.trailing, 44)
  }
}

struct BirthdayCell_Previews: PreviewProvider {
  
  static var previews: some View {
    BirthdayCell(
      model: BirthdayModel(
        id: 1,
        userId: 1,
        name: "M",
        image: "",
        relation: "",
        message: "",
        date: Date(),
        upcomingBirthday: Date(),
        upcomingAge: 1,
        createdAt: Date(),
        updatedAt: Date()
      )
    )
  }
  
}
