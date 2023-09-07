
import SwiftUI

struct AlertViewModifier: ViewModifier {
  
  private let title: String?
  private let message: String
  @Binding private var isPresented: Bool
  
  init(
    title: String?,
    message: String,
    isPresented: Binding<Bool>
  ) {
    self.title = title
    self.message = message
    self._isPresented = isPresented
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
        .blur(radius: isPresented ? 2 : 0)
        .disabled(isPresented)
      
      Color.black
        .ignoresSafeArea()
        .opacity(isPresented ? 0.2 : 0)
      
      if isPresented {
        VStack(spacing: 3) {
          Text(title ?? .emptyString)
            .font(Font.custom(weight: .bold, size: 16))
          
          Text(message)
            .font(Font.custom(weight: .medium, size: 14))
          
          Divider()
            .padding(.vertical, 10)
          
          Button(role: .cancel) {
            withAnimation {
              isPresented.toggle()
            }
          } label: {
            Text(ButtonTitles.ok)
              .font(Font.custom(weight: .bold, size: 16))
              .foregroundColor(Color.primaryColor)
          }
        }
        .foregroundColor(Color.primaryColor)
        .multilineTextAlignment(.center)
        .padding(.all, 15)
        .background(Color.backgroundColor)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.6), radius: 15)
        .padding(.horizontal, 38)
      }
    }
  }
  
}



struct ToastViewModifier: ViewModifier {
  
  private let message: String
  @Binding private var isPresented: Bool
  
  init(
    message: String,
    isPresented: Binding<Bool>
  ) {
    self.message = message
    self._isPresented = isPresented
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
        .blur(radius: isPresented ? 2 : 0)
        .disabled(isPresented)
      
      Color.black
        .ignoresSafeArea()
        .opacity(isPresented ? 0.2 : 0)
      
      if isPresented {
        Text(message)
          .font(Font.custom(weight: .medium, size: 14))
      }
    }
    .foregroundColor(Color.primaryColor)
    .multilineTextAlignment(.center)
    .padding(.all, 15)
    .background(Color.backgroundColor)
    .cornerRadius(30)
    .shadow(color: Color.gray.opacity(0.6), radius: 30)
    .padding(.horizontal, 10)
  }
  
}
