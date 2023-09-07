
import SwiftUI

extension View {
  
  func navigationBar() -> some View {
    modifier(CustomNavigationBarModifier())
  }
  
  func customAlert(
    title: String?,
    message: String,
    isPresented: Binding<Bool>
  ) -> some View {
    modifier(
      AlertViewModifier(
        title: title,
        message: message,
        isPresented: isPresented
      )
    )
  }
  
  
  func toast(
    message: String,
    isPresented: Binding<Bool>
  ) -> some View {
    modifier(
      ToastViewModifier(
        message: message,
        isPresented: isPresented
      )
    )
  }
  
}
