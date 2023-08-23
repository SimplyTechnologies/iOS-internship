
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
      Text("Shop tab")
        .tabItem { TabViewTab(activeTab: $activeTab, tab: .shop) }
        .tag(TabItem.shop)
      
      Text("Profile tab")
        .tabItem { TabViewTab(activeTab: $activeTab, tab: .profile) }
        .tag(TabItem.profile)
    }
  }
  
}
