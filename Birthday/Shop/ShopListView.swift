
import SwiftUI

struct ShopListView: View {
  @ObservedObject var viewModel: ShopListViewModel = ShopListViewModel()
  
  @State private var searchBarIsActive = false
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.backgroundColor.edgesIgnoringSafeArea(.all)
        
        VStack {
          Image("LogoBirthApp")
            .frame(width: 88,
                   height: 40,
                   alignment: .trailing)
          
          ZStack(alignment: .trailing) {
            TextField("Search", text: $viewModel.searchText)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .border(Color.white)
              .cornerRadius(30)
              .padding()
            
            Button(action: {
              if searchBarIsActive {
                viewModel.searchText = ""
              }
              searchBarIsActive = false
            }) {
              Image(systemName: searchBarIsActive || !viewModel.searchText.isEmpty ? "xmark.circle.fill" : "magnifyingglass")
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 24)
          }
          .onChange(
            of: viewModel.searchText,
            perform: { newText in
              if !newText.isEmpty {
                searchBarIsActive = true
              }
            }
          )
          
          Spacer()
          
          ScrollView {
            LazyVStack {
              if viewModel.sortedShops.isEmpty {
                Text("No search results found")
                  .foregroundColor(.gray)
                  .padding()
              } else {
                ForEach(viewModel.sortedShops, id: \.id) { shop in
                  NavigationLink(
                    destination: ShopDetailView(
                      viewModel: ShopDetailViewModel(
                        shop: shop,
                        toasts: viewModel.toasts,
                        onTapFavoriteIcon: viewModel.onTapFavoriteIcon
                      )
                    )
                  ) {
                    ShopView(
                      shop: viewModel.sortedShops[viewModel.sortedShops.firstIndex(of: shop)!]
                    )
                    .environmentObject(viewModel)
                  }
                }
              }
            }
          }
          .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
          }
        }
        
        VStack {
          Spacer()
          ForEach(viewModel.toasts, id: \.self) {
            ToastView(toast: $0)
              .transition(
                .asymmetric(insertion: .move(edge: .bottom),
                            removal: .opacity))
          }
        }
        .animation(.easeInOut, value: viewModel.toasts.count)
        .zIndex(1)
      }
    }
  }
}
