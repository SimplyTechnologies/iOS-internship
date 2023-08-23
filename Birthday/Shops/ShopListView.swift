//
//  ShopListView.swift
//  Birthday
//
//  Created by Shushan Barseghyan on 21.08.23.
//

import SwiftUI

struct Shop: Equatable {
  let id: Int
  let name: String
  let image: Image
  let url: String
  var isFavorite: Bool
}



struct ShopListView: View {
  @State private var shops: [Shop] = [
    Shop(id: 111, name: "McDonald's", image: Image(systemName: "photo.on.rectangle"), url: "https://www.mcdonalds.com/us/en-us.html", isFavorite: false),
    Shop(id: 112, name: "H&M", image: Image(systemName: "photo.on.rectangle"), url: "https://www2.hm.com/en_us/index.html", isFavorite: false),
    Shop(id: 113, name: "Hugo Boss", image: Image(systemName: "photo.on.rectangle"), url: "https://www.hugoboss.com/selectcountry", isFavorite: true),
    Shop(id: 114, name: "KFC", image: Image(systemName: "photo.on.rectangle"), url: "https://global.kfc.com/", isFavorite: false),
    Shop(id: 115, name: "Burger King", image: Image(systemName: "photo.on.rectangle"), url: "https://www.bk.com/", isFavorite: true),
    Shop(id: 116, name: "Zara", image: Image(systemName: "photo.on.rectangle"), url: "https://www.zara.com/", isFavorite: true)
  ]
  
  @State private var searchText = ""
  @State private var searchBarIsActive = false
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      Color.backgroundColor.edgesIgnoringSafeArea(.all)
      
      VStack {
        Image("LogoBirthApp").frame(width: 88,
                                    height: 40,
                                    alignment: .trailing)
        
        //Search bar
        ZStack(alignment: .trailing) {
          
          TextField("Search", text: $searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.white)
            .cornerRadius(30)
            .padding()
          
          Button(action: {
            if searchBarIsActive {
              searchText = ""
            }
            searchBarIsActive.toggle()
          }) {
            
            Image(systemName: searchBarIsActive ? "xmark.circle.fill" : "magnifyingglass")
              .foregroundColor(.gray)
          }
          .padding(.horizontal, 24)
        }
        
        Spacer()
        
        ScrollView {
          let filteredShops = shops.filter {searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
          let sortedShops = filteredShops.sorted { $0.isFavorite && !$1.isFavorite }
          
          VStack {
            
            if sortedShops.isEmpty {
              Text("No search results found")
                .foregroundColor(.gray)
                .padding()
            } else {
              ForEach(sortedShops, id: \.id) { shop in
                NavigationLink(destination: ShopDetailView(shop: shop)) {
                  ShopView(shop: $shops[shops.firstIndex(of: shop)!])
                }
              }
            }
          }
        }
        .onTapGesture {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
      }
    }
  }
}


struct ShopView: View {
  @Binding var shop: Shop
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 30).foregroundColor(.white)
      HStack {
        shop.image.resizable()
          .frame(width: 100,
                 height: 100,
                 alignment: .center)
          .fixedSize()
        
        Text(shop.name).foregroundColor(.black)
        
        Spacer()
        
        Button(action: {
          shop.isFavorite.toggle()
        }) {
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


struct ShopListView_Previews: PreviewProvider {
  static var previews: some View {
    ShopListView()
  }
}
