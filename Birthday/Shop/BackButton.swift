
import SwiftUI

struct BackButton: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    Button {
      self.presentationMode.wrappedValue.dismiss()
    } label: {
      Image("Back").aspectRatio(contentMode: .fit)
        .frame(width: 16, height: 24.04)
    }
  }
  
}
