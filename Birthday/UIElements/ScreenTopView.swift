
import SwiftUI

struct ScreenTopView: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    HStack {
      Button {
        presentationMode.wrappedValue.dismiss()
      } label: {
        Image(Images.backButton.rawValue)
      }
      
      Spacer()
      Image(Images.logo.rawValue)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(
          width: 88,
          height: 40
        )
    }
//    .frame(maxHeight: 60)
    .padding(.horizontal)
  }
  
}
