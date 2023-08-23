//
//  ShopDetailView.swift
//  Birthday
//
//  Created by Shushan Barseghyan on 19.08.23.
//

import SwiftUI

struct ShopDetailView: View {
  var shop: Shop
  
  var body: some View {
    
    ZStack(alignment: .center) {
      Color.backgroundColor.edgesIgnoringSafeArea(.all)
      
      VStack {
        HStack {
          BackButton()
          Spacer()
          Image("LogoBirthApp").frame(width: 88, height: 40, alignment: .trailing)
        } .padding(.horizontal)
        
        shop.image
          .resizable()
          .frame(width: 100, height: 100)
          .padding(.top, 100)
        
        Text(shop.name).font(.title)

          .padding(.vertical, 10)
        
        let link = ("[Web Site](\(shop.url))")
        Text(.init(link))
        
        Spacer()
      }
      .navigationBarBackButtonHidden(true)
    }
  }
}

struct BackButton: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    Button(action: {
      self.presentationMode.wrappedValue.dismiss()
    }) {
      Image("Back")
        .aspectRatio(contentMode: .fit)
        .frame(width: 16, height: 24.04)
    }
  }
}



