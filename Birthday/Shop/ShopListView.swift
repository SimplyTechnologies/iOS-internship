
import SwiftUI

struct ShopListView: View {
  
  @StateObject var viewModel: ShopListViewModel
  @State private var searchBarIsActive = false
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.backgroundColor.edgesIgnoringSafeArea(.all)
        
        VStack {
          Logo()
          
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
            // TODO: - reusable method for keyboard hiding
              .onTapGesture {
                searchBarIsActive = true
              }
            Button {
              if searchBarIsActive {
                viewModel.searchText = ""
              }
              searchBarIsActive = false
              // TODO: - reusable method for keyboard hiding
              UIApplication.shared
                .sendAction(#selector(UIResponder.resignFirstResponder),
                  to: nil,
                  from: nil,
                  for: nil)
            } label: {
              // swiftlint:disable:next line_length
              Image(systemName: searchBarIsActive || !viewModel.searchText.isEmpty ? "xmark.circle.fill" : "magnifyingglass")
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
              if viewModel.isLoading {
                ProgressView("Loading...")
              } else {
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
            }
            .padding(.horizontal, 24)
          }
          .refreshable {
            viewModel.getShops(shopFilter: Api.ShopFilter())
          }
          .frame(maxWidth: .infinity)
          .onAppear {
            viewModel.getShops(shopFilter: Api.ShopFilter())
          }
          .onTapGesture {
            UIApplication.shared
              .sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
              )
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
    }
    
  }
  
}
