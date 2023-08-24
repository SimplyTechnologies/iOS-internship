
import SwiftUI

struct BackButton: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    Button(
      action: {
        self.presentationMode.wrappedValue.dismiss()
      }
    ) {
      Image("Back").aspectRatio(contentMode: .fit).frame(width: 16, height: 24.04).frame(width: 16, height: 24.04).frame(width: 16, height: 24.04).frame(width: 16, height: 24.04)
    }
  }
  
}
