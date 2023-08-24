
import SwiftUI

struct ShopDetailView: View {
  
  @ObservedObject var viewModel: ShopDetailViewModel
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @GestureState private var dragOffset = CGSize.zero
  
  var body: some View {
    
    ZStack(alignment: .center) {
      Color.backgroundColor.edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 16) {
        
        HStack {
          
          BackButton()
          Spacer()
          Logo()
        }
        .padding(.horizontal)
        
        Image(systemName: viewModel.shop.image)
          .resizable()
          .frame(width: 100, height: 100)
          .padding(.top, 100)
        
        Text(viewModel.shop.name)
          .font(.title)
        
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
          }
        }
        Text(.init(viewModel.websiteURL))
          .underline()
          .tint(.black)
        
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
        
        Spacer()
        
      }
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
