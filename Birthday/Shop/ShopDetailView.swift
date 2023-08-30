
import SwiftUI

struct ShopDetailView: View {
  
  @ObservedObject var viewModel: ShopDetailViewModel
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @GestureState private var dragOffset = CGSize.zero
  
  var body: some View {
    
    ZStack(alignment: .top) {
      Color.backgroundColor.edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 16) {
        
        HStack {
          
          BackButton()
          Spacer()
          Logo()
        }
        .padding(.horizontal)
        
        let asyncImageURL = URL(string: viewModel.shop.image)
        AsyncImage(url: asyncImageURL) { image in
          image
            .resizable()
            .scaledToFill()
        } placeholder: {
            Text(viewModel.shop.name.prefix(1))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
              .font(.largeTitle)
              .background(Color.secondaryColor)
        }
        .frame(width: 100, height: 100)
        .cornerRadius(50)
        .padding(.top, 100)
        
        Text(viewModel.shop.name)
          .font(.title)
          .padding(.horizontal, 20)
          .multilineTextAlignment(.center)

        HStack {
          ForEach(0..<5) { index in
            Image(systemName: "star.fill")
              .foregroundColor(index < Int(viewModel.shop.rate) ? .orange : .gray)
          }
        }
        .padding(.vertical, 15)
        
        Button {
          if let phoneURL = URL(string: viewModel.phone), UIApplication
            .shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(
              phoneURL,
              options: [:],
              completionHandler: nil
            )
          }
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
          if viewModel.shop.isFavorite {
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
      .navigationBarBackButtonHidden(true)
    }
    .gesture(
      DragGesture()
        .updating(
          $dragOffset,
          body: { (value, _, _) in
            if value.startLocation.x < 200 && value.translation.width > 100 {
              self.mode.wrappedValue.dismiss()
              
            }
          }
        )
    )
  }
  
}
