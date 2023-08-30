
import SwiftUI

struct ToastView: View {
  
  let toast: Toast
  
  var body: some View {
    Text(toast.message).frame(maxWidth: .infinity)
      .padding()
      .background(Color.backgroundColor)
      .cornerRadius(30)
      .shadow(radius: 10)
      .padding(.horizontal, 20)
  }
  
}
