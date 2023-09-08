
import SwiftUI

extension View {
  
  func navigationBar() -> some View {
    modifier(CustomNavigationBarModifier())
  }
  
  func customAlert(
    type: AlertType,
    title: String?,
    message: String,
    action: (() -> Void)? = nil,
    secondaryAction: (() -> Void)? = nil,
    isPresented: Binding<Bool>
  ) -> some View {
    modifier(
      AlertViewModifier(
        type: type,
        title: title,
        message: message,
        action: action,
        secondaryAction: secondaryAction,
        isPresented: isPresented
      )
    )
  }
  
//  func toast(
//    message: String,
//    isPresented: Binding<Bool>
//  ) -> some View {
//    modifier(
//      ToastViewModifier(
//        message: message,
//        isPresented: isPresented
//      )
//    )
//  }
  
}
