
import SwiftUI

struct HomeView: View {
  
  @StateObject var viewModel: HomeViewModel
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.top)
      VStack {
        Image("LogoBirthApp")
        if viewModel.birthdays.isEmpty && !viewModel.isLoading {
          EmptyStateView(description: "Let's add some birthdays.")
        } else {
          birthdaysView
        }
      }
    }
    .navigationBarHidden(true)
    .refreshable {
      viewModel.getBirthdays()
    }
    .overlay {
      viewModel.isLoading ? ProgressView() : nil
    }
  }
  
  private var birthdaysView: some View {
    ScrollView {
      LazyVStack(spacing: 18) {
        ForEach(viewModel.birthdays, id: \.self) { birthday in
          NavigationLink {
            BirthdayDetailsScreen(
              viewModel: BirthdayDetailsViewModel(
                birthdayDetails: birthday,
                birthdaysRepository: BirthdaysRepositoryImpl()
              )
            )
          } label: {
            BirthdayCell(model: birthday)
          }
        }
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 24)
    }
  }
  
}

struct HomeView_Previews: PreviewProvider {
  
  static var previews: some View {
    HomeView(
      viewModel: HomeViewModel(
        birthdayRepository: BirthdaysRepositoryImpl()
      )
    )
  }
  
}
