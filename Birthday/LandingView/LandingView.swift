
import SwiftUI

struct LandingView: View {
  
  @ObservedObject private var viewModel = LandingViewModel()
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.backgroundColor
          .ignoresSafeArea()
        
        VStack(spacing: 8) {
          Image(Images.logo.rawValue)
            .resizable()
            .frame(width: 185, height: 93)
            .padding(.bottom, 50)
          
          // MARK: Sign In button
          NavigationLink(
            Titles.signIn,
            isActive: $viewModel.isLoggedInOnce
          ) {
            SignInView()
          }
          .buttonStyle(
            PartiallyRoundedButtonStyle(
              corners: [.topLeft, .topRight, .bottomRight],
              backgroundColor: Color.secondaryColor.opacity(0.7),
              foregroundColor: Color.primaryColor
            )
          )
          
          // MARK: Register button
          NavigationLink(
            Titles.register
            
          ) {
            RegisterView()
          }
          .buttonStyle(
            PartiallyRoundedButtonStyle(
              corners: [.topLeft, .bottomRight, .bottomLeft],
              backgroundColor: Color.primaryColor,
              foregroundColor: Color.secondaryColor
            )
          )
        }
        .padding(.horizontal, 68)
      }
    }
    .accentColor(Color.primaryColor)
    .navigationBarHidden(true)
  }
  
}

struct LandingView_Previews: PreviewProvider {
  
  static var previews: some View {
    LandingView()
  }
  
}
