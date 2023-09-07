
import SwiftUI

struct MainView: View {
  
  @StateObject private var viewModel = MainViewModel()
  
  var body: some View {
    if viewModel.isAuthorized {
      TabBarView()
    } else {
      LandingView()
    }
  }
  
}

struct MainView_Previews: PreviewProvider {
  
  static var previews: some View {
    MainView()
  }
  
}
