
import SwiftUI

struct LandingView: View {
  
  // MARK: - Body
  var body: some View {
    ZStack {
      // MARK: Background
      Color.backgroundColor
        .ignoresSafeArea()
      
      VStack(spacing: 8) {
        Image(Images.logo.rawValue)
          .resizable()
          .frame(height: 93)
          .padding(.horizontal, 104)
          .padding(.bottom, 50)
        
        // MARK: Sign In button
        NavigationLink(Titles.signIn) {
          SignInView()
        }
        .buttonStyle(
          PartiallyRoundedButtonStyle(
            corners: [.topLeft, .topRight, .bottomRight],
            backgroundColor: Color.secondaryColor.opacity(0.7),
            foregroundColor: Color.primaryColor
          )
        )
        .padding(.horizontal, 68)
        
        // MARK: Register button
        NavigationLink(Titles.register) {
          RegisterView()
        }
        .buttonStyle(
          PartiallyRoundedButtonStyle(
            corners: [.topLeft, .bottomRight, .bottomLeft],
            backgroundColor: Color.primaryColor,
            foregroundColor: Color.secondaryColor
          )
        )
        .padding(.horizontal, 68)
      }
    }
  }
  
}

// MARK: - Preview
struct LandingView_Previews: PreviewProvider {
  static var previews: some View {
    LandingView()
  }
}
