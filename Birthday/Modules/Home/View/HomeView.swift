
import SwiftUI

struct HomeView: View {
  
  @StateObject var viewModel: HomeViewModel
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.top)
      VStack {
        ZStack(alignment: .trailing) {
          if !viewModel.birthdays.isEmpty && !viewModel.isLoading {
            Button {
              
            } label: {
              Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.secondaryColor)
            }
          }
          HStack {
            Spacer()
            Image("LogoBirthApp")
            Spacer()
            
          } .padding(.horizontal, 24)
            .padding(.vertical, 10)
        }.padding(.horizontal, 24)
        if viewModel.birthdays.isEmpty && !viewModel.isLoading {
          Spacer()
          addNewBirthdayButton
            .padding(.bottom, 20)
        } else {
          if viewModel.isLoading {
            Spacer()
            ProgressView()
            Spacer()
          } else {
            birthdaysView
          }
        }
      }
    }
    .onAppear {
      viewModel.getBirthdays()
    }
    .edgesIgnoringSafeArea(.top)
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
      .animation(.easeInOut, value: viewModel.birthdays)
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
