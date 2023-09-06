
import SwiftUI

struct ShopDetailView: View {
  
  @ObservedObject var viewModel: ShopDetailViewModel
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  var body: some View {
    ScrollView {
      
      ZStack(alignment: .top) {
        Color.backgroundColor
          .edgesIgnoringSafeArea(.all)
        
        VStack(spacing: 15) {
          let asyncImageURL = URL(string: viewModel.shop.image)
          AsyncImage(url: asyncImageURL) { image in
            image
              .resizable()
              .scaledToFill()
          } placeholder: {
            Text(
              viewModel.shop.name
              .prefix(1)
            )
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .font(.largeTitle)
              .background(Color.secondaryColor)
          }
          .frame(width: 100, height: 100)
          .cornerRadius(50)
          .padding(.top, 80)
          
          Text(viewModel.shop.name)
            .font(Font.custom(weight: .bold, size: 20))
            .padding(.horizontal, 20)
            .multilineTextAlignment(.center)
          
          HStack {
            ForEach(0..<5) { index in
              Image(systemName: "star.fill")
                .foregroundColor(index < Int(viewModel.shop.rate) ? .orange : .gray)
            }
          }
          .padding(.vertical, 10)
          
          Button {
            UIApplication.shared.openPhoneURL(viewModel.phone)
          } label: {
            (
              Text("Phone: ")
              +
              Text(viewModel.shop.phone)
                .underline()
            )
            .foregroundColor(.black)
          }
          
          if let googleMapsURL = URL(string: viewModel.addressURLString) {
            Link(destination: googleMapsURL) {
              (
                Text("Address: ")
                +
                Text(viewModel.shop.address)
                  .underline()
              )
              .foregroundColor(.black)
              .padding(.horizontal, 20)
            }
          }
          
          if !viewModel.shop.url.isEmpty {
            Text(.init(viewModel.websiteURL))
              .underline()
              .tint(.black)
          }
          
          Button {
            viewModel.onTapFavoriteIcon(shop: viewModel.shop)
          } label: {
            if viewModel.shop.favoriteIsLoading {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(.gray)
            } else if viewModel.shop.isFavorite {
              Image(systemName: "heart.fill")
                .foregroundColor(.red)
            } else {
              Image(systemName: "heart")
                .foregroundColor(.black)
            }
          }
          Spacer()
        }
        VStack {
          Spacer()
          ForEach(viewModel.toasts, id: \.self) {
            ToastView(toast: $0)
              .transition(
                .asymmetric(
                  insertion: .move(edge: .bottom),
                  removal: .opacity)
              )
          }
        }
        .animation(
          .easeInOut,
          value: viewModel.toasts.count
        )
      }
    }
    .navigationBar()
    .font(Font.custom(weight: .bold, size: 20))
    
  }
  
}
