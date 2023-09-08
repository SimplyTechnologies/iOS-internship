
import SwiftUI

enum AlertType {
  case primary
  case secondary
}

struct AlertViewModifier: ViewModifier {
  
  var type: AlertType
  
  private let title: String?
  private let message: String
  
//  var secondaryButtonTitle: String?
  
  var action: (() -> Void)? = nil
  var secondaryAction: (() -> Void)? = nil
  
  @Binding private var isPresented: Bool
  
  init(
    type: AlertType,
    title: String?,
    message: String,
    action: (() -> Void)? = nil,
    secondaryAction: (() -> Void)? = nil,
    isPresented: Binding<Bool>
  ) {
    self.type = type
    self.title = title
    self.message = message
    self._isPresented = isPresented
    self.action = action
    self.secondaryAction = secondaryAction
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
          
          HStack {
            if type == .secondary {
              Button {
                withAnimation {
                  if let secondaryAction = secondaryAction {
                    secondaryAction()
                  }
                  isPresented.toggle()
                }
              } label: {
                Text("Yes")
                  .font(Font.custom(weight: .bold, size: 16))
                  .foregroundColor(Color.primaryColor)
              } .frame(maxWidth: .infinity)
              
              Spacer()
            }
            
            Button(role: .cancel) {
              withAnimation {
                if let action = action {
                  action()
                }
                isPresented.toggle()
              }
            } label: {
              Text(type == .primary ? ButtonTitles.ok : "No")
                .font(Font.custom(weight: .bold, size: 16))
                .foregroundColor(Color.primaryColor)
            } .frame(maxWidth: .infinity)
            
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
