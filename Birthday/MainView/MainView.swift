
import SwiftUI

struct MainView: View {
  
  @StateObject private var viewModel = MainViewModel()
  
  var body: some View {
    #warning("Добавить анимацию")
    if viewModel.isAuthorized {
      TabBarView()
    } else {
      NavigationView {
        LandingView()
      }
    }
  }
  
}

struct MainView_Previews: PreviewProvider {
  
  static var previews: some View {
    MainView()
  }
  
}
