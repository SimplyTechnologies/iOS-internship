
import SwiftUI

struct LandingView: View {
  
  // MARK: - Body
  var body: some View {
    NavigationView {
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
            if isTokenExist() {
              TabBarView()
            } else {
              SignInView()
            }
          }
          .buttonStyle(
            PartiallyRoundedButtonStyle(
              corners: [.topLeft,.topRight, .bottomRight],
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
  
  private func isTokenExist() -> Bool {
    guard let tokenCreateDate = UserDefaults.standard.object(forKey: SignInKeys.tokenCreationDate.rawValue) as? Date
    else { return false }
    
    let currentDate = Date()
    let numberOfDays = Calendar(identifier: .gregorian).numberOfDaysBetween(tokenCreateDate, and: currentDate)
    
    if numberOfDays <= 90 {
      return true
    } else {
      UserDefaults.standard.removeObject(forKey: SignInKeys.token.rawValue)
      UserDefaults.standard.removeObject(forKey: SignInKeys.tokenCreationDate.rawValue)
      return false
    }
  }
  
}

// MARK: - Preview
struct LandingView_Previews: PreviewProvider {
  static var previews: some View {
    LandingView()
  }
}
