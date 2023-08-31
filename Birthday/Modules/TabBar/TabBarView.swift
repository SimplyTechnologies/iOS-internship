
import SwiftUI

struct TabBarView: View {
  
  @State var activeTab: TabItem = .home
  
  init() {
    let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
    tabBarAppearance.configureWithDefaultBackground()
    tabBarAppearance.backgroundColor = UIColor(Color.secondaryColor)
    UITabBar.appearance().standardAppearance = tabBarAppearance
    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
  }
  
  var body: some View {
    tabView
  }
  
  private var tabView: some View {
    TabView(selection: $activeTab) {
      NavigationView {
        HomeView(
          viewModel: HomeViewModel(
            birthdayRepository: BirthdaysRepositoryImpl()
          )
        )
      }
      .accentColor(Color.primaryColor)
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
