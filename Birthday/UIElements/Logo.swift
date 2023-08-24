
import SwiftUI

struct Logo: View {
  
  var body: some View {
    Image("LogoBirthApp")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(
        width: 88,
        height: 40
      )
  }
  
}
