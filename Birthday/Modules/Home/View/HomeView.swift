
import SwiftUI

struct HomeView: View {
  
  @StateObject var viewModel: HomeViewModel
  @StateObject var addBirtdayViewModel: AddBirthdayViewModel
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.top)
      VStack {
        ZStack(
          alignment: .trailing
        ) {
          NavigationLink {
            AddBirthdayScreen(
              viewModel: AddBirthdayViewModel(
                birthdayDetails: addBirtdayViewModel.birthdayDetails,
                birthdaysRepository: BirthdaysRepositoryImpl()
              ),
              homeScreenViewModel: viewModel
            )
          } label: {
            Image(
              systemName: "plus"
            )
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.secondaryColor)
          }
          HStack {
            Spacer()
            Image("LogoBirthApp")
            Spacer()
          }
        } .padding(.horizontal, 24)
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
    .navigationTitle("")
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
