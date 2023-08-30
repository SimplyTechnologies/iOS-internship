
import SwiftUI

struct ShopView: View {
  
  @ObservedObject var viewModel: ShopListViewModel
  
  var shop: Shop
  
  var body: some View {
    
    HStack {
      let asyncImageURL = URL(string: shop.image)
      AsyncImage(url: asyncImageURL) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        Text(shop.name.prefix(1))
          .foregroundColor(.black)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .font(.largeTitle)
          .background(Color.secondaryColor)
      }
      .frame(width: 70, height: 70)
      .cornerRadius(35)
      .padding(.trailing, 14)
      
      Text(shop.name)
        .foregroundColor(.black)
        .multilineTextAlignment(.leading)
      
      Spacer()
      
      Button {
        withAnimation {
          viewModel.onTapFavoriteIcon(shop)
        }
      } label: {
        if shop.isFavorite {
          Image(systemName: "heart.fill")
            .foregroundColor(.red)
        } else {
          Image(systemName: "heart")
            .foregroundColor(.black)
          
        }
      }
    }
    .padding(.horizontal, 15)
    .padding(.vertical, 20)
    .background(Color.white)
    .cornerRadius(30)
  }
}
