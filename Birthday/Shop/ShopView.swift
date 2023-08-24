
import SwiftUI

struct ShopView: View {
  
  @EnvironmentObject var viewModel: ShopListViewModel
  
  var shop: Shop
  
  var body: some View {
    
    ZStack {
      RoundedRectangle(cornerRadius: 30)
        .padding(.horizontal)
        .foregroundColor(.white)
      
      HStack {
        Image(systemName: shop.image)
          .resizable()
          .frame(width: 100,
                 height: 100,
                 alignment: .center)
          .fixedSize()
        
        Text(shop.name).foregroundColor(.black)
        
        Spacer()
        
        Button(action: {
          withAnimation {
            viewModel.onTapFavoriteIcon(shop: shop)
          }
        })
        {
          if shop.isFavorite {
            Image(systemName: "heart.fill").foregroundColor(.red)
          } else {
            Image(systemName: "heart").foregroundColor(.black)
            
          }
        }
      }
      .padding(.vertical, 5)
      .padding(.horizontal, 24)
      
    }
  }
}
