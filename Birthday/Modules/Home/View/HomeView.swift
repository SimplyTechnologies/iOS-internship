
import SwiftUI

struct HomeView: View {
  
  @StateObject var viewModel: HomeViewModel
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.top)
      VStack {
        Image("LogoBirthApp")
          .padding(.vertical, 10)
        if viewModel.birthdays.isEmpty && !viewModel.isLoading {
          Spacer()
          addNewBirthdayButton
            .padding(.bottom, 20)
        } else {
          birthdaysView
        }
      }
    }
    .navigationBarHidden(true)
    .onAppear {
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
  
  private var addNewBirthdayButton: some View {
    // TODO: - Remove when reusable buttons will be ready
    Button {
      
    } label: {
      Text("Add a New Birthday")
        .padding()
        .background(Color.primaryColor)
        .foregroundColor(Color.secondaryColor)
        .cornerRadius(16)
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
