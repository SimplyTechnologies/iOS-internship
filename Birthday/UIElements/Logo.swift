
import SwiftUI

struct Logo: View {
  
  var imageName = "logo"
  
  var body: some View {
    Image("LogoBirthApp")
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
  
}
