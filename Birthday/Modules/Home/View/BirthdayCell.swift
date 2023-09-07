
import SwiftUI

struct BirthdayCell: View {
  
  var model: BirthdayModel
  
  var body: some View {
    HStack {
      imageView
        .padding(.trailing)
      VStack(alignment: .leading, spacing: 15) {
        Text(model.name)
          .font(Font.custom(weight: .bold, size: 20))
        Text(model.date.stringFromDate())
          .font(Font.custom(weight: .bold, size: 18))
      }
      Spacer()
    }
    .foregroundColor(.black)
    .padding(.vertical, 20)
    .padding(.horizontal, 16)
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(24)
    .shadow(color: Color.gray.opacity(0.3), radius: 1, x: 1, y: 1)
  }
  
  private var imageView: some View {
    Group {
      if let imageData = model.image,
         !imageData.isEmpty,
         let data = Data(base64Encoded: imageData),
         let uiImage = UIImage(data: data) {
        Image(uiImage: uiImage)
          .resizable()
          .frame(width: 70, height: 70)
          .scaledToFill()
          .cornerRadius(35)
          
      } else {
        ZStack {
          Color.secondaryColor
          Image(systemName: "person")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(Color.white)
        }
        .cornerRadius(40)
      }
    }
    .frame(width: 70, height: 70)
    .cornerRadius(35)
  }
  
  
  //    AsyncImage(url: URL(string: model.image)) { image in
  //      image
  //        .resizable()
  //        .scaledToFill()
  //        .frame(width: 70, height: 70)
  //        .cornerRadius(50)
  //    } placeholder: {
  //      ZStack {
  //        Color.secondaryColor
  //        Image(systemName: "person")
  //          .resizable()
  //          .frame(width: 30, height: 30)
  //          .foregroundColor(Color.white)
  //      }
  //        .cornerRadius(40)
  //    }
  //    .frame(width: 70, height: 70)
  //    .padding(.trailing, 44)
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
