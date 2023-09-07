
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
          ),
          addBirtdayViewModel: AddBirthdayViewModel(
            birthdayDetails: BirthdayModel(
              id: 0,
              userId: 0,
              name: "",
              image: "",
              relation: "",
              message: "",
              date: Date(),
              upcomingBirthday: Date(),
              upcomingAge: 0,
              createdAt: Date(),
              updatedAt: Date()),
            birthdaysRepository: BirthdaysRepositoryImpl()
          )
        )
      }
        .tabItem { TabViewTab(activeTab: $activeTab, tab: .home) }
        .tag(TabItem.home)
      
      NavigationView {
        ShopListView(
          viewModel: ShopListViewModel()
        )
      }
        .tabItem { TabViewTab(activeTab: $activeTab, tab: .shop) }
        .tag(TabItem.shop)
      
      NavigationView {
        ProfileScreen(
          viewModel: ProfileScreenViewModel(
            userRepository: UserRepositoryImpl()
          )
        )
      }
      .tabItem { TabViewTab(activeTab: $activeTab, tab: .profile) }
      .tag(TabItem.profile)
    }
  }
  
}
