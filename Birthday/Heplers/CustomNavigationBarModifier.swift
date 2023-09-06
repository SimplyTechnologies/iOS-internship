
import SwiftUI

struct CustomNavigationBarModifier: ViewModifier {
  
  @Environment(\.presentationMode) var presentationMode
  @GestureState private var dragOffset = CGSize.zero
  
  func body(content: Content) -> some View {
    ZStack {
      Color.backgroundColor.ignoresSafeArea()
      VStack {
        HStack {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(Images.backButton.rawValue)
          }
          Spacer()
          Image(Images.logo.rawValue)
        } .padding(.horizontal, 24)
        content
      }
    } .gesture(
      DragGesture()
        .updating(
          $dragOffset,
          body: { (value, _, _) in
            if value.startLocation.x < 200 && value.translation.width > 100 {
              self.presentationMode.wrappedValue.dismiss()
            }
          }
        )
    )
    .navigationBarHidden(true)
  }
  
}
