
import SwiftUI

struct ShopView: View {
  
  @EnvironmentObject var viewModel: ShopListViewModel
  
  var shop: Shop
  
  var body: some View {
    
    HStack {
      AsyncImage(url: URL(string: shop.image)) { image in
        image
          .resizable()
          .frame(width: 70, height: 70)
          .scaledToFit()
          .cornerRadius(35)
      } placeholder: {
        Color.secondaryColor
          .cornerRadius(35)
      }
      .frame(width: 70, height: 70)
      .padding(.trailing, 14)
      
      Text(shop.name).foregroundColor(.black)
        .multilineTextAlignment(.leading)
      
      Spacer()
      
      Button {
        withAnimation {
          viewModel.onTapFavoriteIcon(shop: shop)
        }
      } label: {
        if shop.isFavorite {
          Image(systemName: "heart.fill").foregroundColor(.red)
        } else {
          Image(systemName: "heart").foregroundColor(.black)
          
        }
      }
    }
    .padding(.horizontal, 15)
    .padding(.vertical, 20)
    .background(Color.white)
    .cornerRadius(30)
  }
}
