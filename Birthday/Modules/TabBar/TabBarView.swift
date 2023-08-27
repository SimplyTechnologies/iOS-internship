
import SwiftUI

struct TabBarView: View {
  
  @State var activeTab: TabItem = .home
  
  init() {
    UITabBar.appearance().backgroundColor = UIColor(Color.secondaryColor)
  }
  
  var body: some View {
    tabView
  }
  
  private var tabView: some View {
    TabView(selection: $activeTab) {
      Text("Home tab")
        .tabItem { TabViewTab(activeTab: $activeTab, tab: .home) }
        .tag(TabItem.home)
      ShopListView(viewModel: ShopListViewModel())
        .tabItem { TabViewTab(activeTab: $activeTab, tab: .shop) }
        .tag(TabItem.shop)
      
      ProfileScreen(viewModel: ProfileScreenViewModel())
        .tabItem { TabViewTab(activeTab: $activeTab, tab: .profile) }
        .tag(TabItem.profile)
    }
  }
  
}
