
import SwiftUI

struct EmptyStateView: View {
  
  let description: String
  
  var body: some View {
    VStack {
      Spacer()
      Image("empty-state")
        .resizable()
        .frame(width: 250, height: 250)
      Text("Ouhh... it's empty in here.")
        .font(Font.custom(weight: .bold, size: 18))
      Text(description)
        .foregroundColor(.gray)
        .font(Font.custom(weight: .bold, size: 16))
      Spacer()
    }
  }
}

struct EmptyStateView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyStateView(description: "Let's add some birthdays.")
  }
}
