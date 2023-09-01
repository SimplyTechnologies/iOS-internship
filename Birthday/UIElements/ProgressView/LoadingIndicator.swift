
import SwiftUI

struct LoadingIndicator: View {
  
  var body: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle())
      .tint(Color.primaryColor)
  }
  
}
