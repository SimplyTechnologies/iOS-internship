
import SwiftUI

struct ShopListView: View {
  
  @StateObject var viewModel: ShopListViewModel
  @State private var searchBarIsActive = false
  
  var body: some View {
    ZStack {
      Color.backgroundColor.edgesIgnoringSafeArea(.all)
      
      VStack {
        Image(Images.logo.rawValue)
        
        ZStack(alignment: .trailing) {
          TextField("Search", text: $viewModel.searchText)
            .accentColor(.secondaryColor)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.white)
            .cornerRadius(30)
            .padding(.vertical, 10)
            .shadow(color: Color.gray.opacity(0.3), radius: 0.5, x: 0.5, y: 0.5)
            .onChange(of: viewModel.searchText) { newValue in
              viewModel.searchText = newValue
                .trimmingCharacters(in: .newlines)
            }
            .onTapGesture {
              searchBarIsActive = true
            }
          Button {
            if searchBarIsActive {
              viewModel.searchText = ""
            }
            searchBarIsActive = false
            UIApplication.shared.endEditing()
          } label: {
            Image(
              systemName: searchBarIsActive || !viewModel.searchText.isEmpty ? "xmark.circle.fill" : "magnifyingglass"
            )
            .foregroundColor(.gray)
          }
          .padding(.trailing, 10)
        }
        .padding(.horizontal, 24)
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
          VStack(spacing: 18) {
            if viewModel.sortedShops.isEmpty && !viewModel.isLoading {
              EmptyStateView(description: "Please try again.")
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
                    viewModel: viewModel,
                    shop: shop
                  )
                  .environmentObject(viewModel)
                }
                .transition(.move(edge: .top).combined(with: .opacity))
              }
              .shadow(color: Color.gray.opacity(0.3), radius: 1, x: 1, y: 1)
              .animation(.easeInOut, value: viewModel.sortedShops)
            }
            
          }
          .padding(.horizontal, 24)
          .padding(.bottom, 24)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity)
        .onTapGesture {
          UIApplication.shared.endEditing()
        }
      }
      
      VStack {
        Spacer()
        ForEach(viewModel.toasts, id: \.self) {
          ToastView(toast: $0)
            .transition(
              .asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
          
        }
      }
      .animation(.easeInOut, value: viewModel.toasts.count)
      .zIndex(1)
    }
    .overlay {
      viewModel.isLoading ? ProgressView() : nil
    }
    .refreshable {
      viewModel.getShops(shopFilter: Api.ShopFilter())
    }
  }
  
}
